# Deploying the portfolio behind final-cut's nginx

The portfolio runs as a **Deno SSR container** (`portfolio:3000`) on the same droplet as
[`final-cut`](../../final-cut), and final-cut's nginx reverse-proxies the portfolio's domain
to it. No separate nginx — it reuses final-cut's TLS, security headers, rate limiting,
fail2ban, and certbot. The Dockerfile mirrors `final-cut/frontend/Dockerfile`.

## Files (in this repo)

| File | Purpose |
| --- | --- |
| `Dockerfile` | Multi-stage Deno build → distroless `production` running `.output/server/index.mjs` (port 3000). |
| `deploy/nginx/portfolio.conf.template` | nginx vhost (envsubst) — copy into final-cut's `conf.d` templates. |
| `deploy/compose.portfolio.yml` | Compose overlay adding the `portfolio` service + wiring nginx to it. |

## Prerequisites

- Portfolio repo checked out on the droplet next to final-cut (so `../portfolio` resolves), or
  push an image to your registry and reference it with `image:` instead of `build:`.
- DNS: point your portfolio domain (e.g. `andrewbilenduke.com` and `www.`) **A record → droplet IP**.

## Steps (run from the `final-cut` repo)

1. **Install the vhost template**
   ```sh
   cp ../portfolio/deploy/nginx/portfolio.conf.template nginx/templates/conf.d/
   ```

2. **Set env** (in final-cut's `.env`)
   ```sh
   PORTFOLIO_DOMAIN=andrewbilenduke.com
   NUXT_PUBLIC_DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/XXX/YYY
   ```
   The webhook is read at **runtime** by the SSR server — change it and `restart` the
   container, no rebuild.

3. **Issue the TLS certificate** (webroot/ACME; the HTTP vhost above serves the challenge).
   Bring the stack up once (HTTP works before the cert exists), then:
   ```sh
   docker compose -f docker-compose.yml -f docker-compose.prod.yml \
     -f ../portfolio/deploy/compose.portfolio.yml \
     run --rm certbot certonly --webroot -w /var/www/certbot \
     -d "$PORTFOLIO_DOMAIN" -d "www.$PORTFOLIO_DOMAIN" \
     --agree-tos -m ops@"$PORTFOLIO_DOMAIN"
   ```
   This writes `/etc/letsencrypt/live/$PORTFOLIO_DOMAIN/` (the paths the vhost env points at).
   The existing certbot sidecar auto-renews it; renewals signal nginx to reload.

4. **Bring it up**
   ```sh
   docker compose -f docker-compose.yml -f docker-compose.prod.yml \
     -f ../portfolio/deploy/compose.portfolio.yml up -d --build
   ```

5. **Verify**
   ```sh
   curl -I https://$PORTFOLIO_DOMAIN          # 200, HSTS + CSP headers
   docker compose ps portfolio                # healthy
   ```

## CI/CD (GitHub Actions) — mirrors final-cut

| Workflow | Trigger | Does |
| --- | --- | --- |
| `.github/workflows/ci.yml` | push / PR to `main` | `deno install` + `deno task build` |
| `.github/workflows/codeql.yml` | push / PR / weekly | JS/TS security scan |
| `.github/workflows/release.yml` | tag `v*.*.*` (or manual) | build → push `ghcr.io/abilenduke/portfolio:<tag>` → SSH-deploy to droplet |

**Ongoing deploy:** `git tag -a v1.0.0 -m "Portfolio v1.0.0" && git push origin v1.0.0`.
The release workflow builds the image, pushes it to GHCR, SSHes to the droplet, pulls, and
rolls **only** the `portfolio` container (nginx is left running — it re-resolves
`portfolio:3000` via Docker DNS, so the live final-cut site is never disturbed), then
health-checks `https://$PORTFOLIO_DOMAIN/`.

**Repo secrets** (Settings → Secrets → Actions — per-repo, even though the droplet is shared
with final-cut): `SSH_HOST`, `SSH_USER`, `SSH_PRIVATE_KEY`, `SSH_PORT` (optional). The
`GITHUB_TOKEN` pushes to GHCR automatically.

## One-time droplet bootstrap

Done once over SSH (the droplet already runs final-cut at `/opt/final-cut`):

```sh
# 1. Clone the portfolio next to final-cut
sudo mkdir -p /opt/portfolio && sudo chown "$USER" /opt/portfolio
git clone https://github.com/ABilenduke/portfolio.git /opt/portfolio

# 2. Install the vhost into final-cut's nginx templates
cp /opt/portfolio/deploy/nginx/portfolio.conf.template /opt/final-cut/nginx/templates/conf.d/

# 3. Add env to /opt/final-cut/.env (chmod 600)
#    PORTFOLIO_DOMAIN=andrewbilenduke.com
#    NUXT_PUBLIC_DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/...

# 4. Point DNS: PORTFOLIO_DOMAIN (+ www) A record -> droplet IP

# 5. Recreate nginx so it renders the new vhost (one brief nginx restart),
#    then issue the cert, then bring up the portfolio container:
cd /opt/final-cut
export IMAGE_TAG=v1.0.0   # or 'latest'
COMPOSE="docker compose -f docker-compose.yml -f docker-compose.prod.yml -f /opt/portfolio/deploy/compose.registry.yml"
$COMPOSE up -d nginx
$COMPOSE run --rm certbot certonly --webroot -w /var/www/certbot \
  -d "$PORTFOLIO_DOMAIN" -d "www.$PORTFOLIO_DOMAIN" --agree-tos -m "ops@$PORTFOLIO_DOMAIN"
$COMPOSE up -d --wait portfolio
```

GHCR pull auth reuses final-cut's existing `docker login ghcr.io` on the droplet. After this,
every `v*.*.*` tag deploys automatically via `release.yml`.

## Notes

- The portfolio vhost is **not** `default_server` — final-cut's customer vhost keeps that, so
  unknown Host headers still land on final-cut, not the portfolio.
- CSP allows `connect-src https://discord.com` for the contact form. If you use a legacy
  `discordapp.com` webhook URL, add that host too.
- `map $http_upgrade $connection_upgrade` is intentionally **not** redefined in the portfolio
  vhost (it already exists in `default.conf.template`, same `http{}` block).
- Separate registrable domain ⇒ separate cert (above). If you instead put the portfolio on a
  `*.andrewbilenduke.com` subdomain that shares final-cut's SAN cert, point the vhost's
  `ssl_certificate*` env at final-cut's cert dir instead and skip step 3.
