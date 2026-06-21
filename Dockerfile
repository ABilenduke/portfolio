# Portfolio — Deno + Nuxt 4.
# Mirrors final-cut/frontend/Dockerfile so it deploys onto the same droplet and
# is reverse-proxied by final-cut's nginx (proxies / -> portfolio:3000).
# Pinned image tags (fixed Docker versions). Runs the Nitro server under Deno,
# so NUXT_PUBLIC_DISCORD_WEBHOOK_URL is read at RUNTIME (no rebuild to change it).

# ── Base ─────────────────────────────────────
FROM denoland/deno:debian-2.7.11 AS base
WORKDIR /app
COPY package.json deno.json deno.lock ./
RUN deno install
COPY . .

# ── Development ──────────────────────────────
# Optional: `docker build --target development`. Dev user matches host UID/GID
# so a bind-mounted ./app shares ownership. `deno task dev` already sets
# NITRO_NO_UNIX_SOCKET=1 (see deno.json) so Nitro's dev server works under Deno.
FROM base AS development
ARG DEV_UID=1000
ARG DEV_GID=1000
RUN groupadd -g ${DEV_GID} devuser \
    && useradd -u ${DEV_UID} -g devuser -m devuser \
    && mkdir -p /home/devuser/.cache/deno \
    && chown -R devuser:devuser /home/devuser /app
ENV DENO_DIR=/home/devuser/.cache/deno
USER devuser
EXPOSE 3000
CMD ["deno", "task", "dev"]

# ── Build (Nitro server output) ──────────────
FROM base AS build
# Baked only if a route is prerendered; runtime SSR uses the production env below.
ARG NUXT_PUBLIC_DISCORD_WEBHOOK_URL=""
ENV NUXT_PUBLIC_DISCORD_WEBHOOK_URL=${NUXT_PUBLIC_DISCORD_WEBHOOK_URL}
RUN deno task build

# ── Production ───────────────────────────────
FROM denoland/deno:distroless-2.7.11 AS production
WORKDIR /app
COPY --from=build /app/.output .output
# Set at runtime (docker run -e / compose environment) to enable real delivery.
ENV NUXT_PUBLIC_DISCORD_WEBHOOK_URL=""
EXPOSE 3000
CMD ["run", "--allow-net", "--allow-read", "--allow-env", ".output/server/index.mjs"]
