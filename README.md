# Andrew Bilenduke — Portfolio

A static personal portfolio site. Built with **Nuxt 4 / Vue 3**, statically generated, and
**run with [Deno](https://deno.com)** (not Node/npm). The design was authored in
[Claude Design](https://claude.ai/design) and ported to Vue single-file components.

- **Theme** — light/dark via `@nuxtjs/color-mode` (`data-theme` on `<html>`, no flash).
- **Fonts** — Sora, Inter, JetBrains Mono, self-hosted at build time by `@nuxt/fonts`.
- **Icons** — `lucide-vue-next`.
- **Contact** — the contact form posts to a **Discord webhook** (see below).

## Requirements

- [Deno](https://deno.com) 2.x (this repo uses Deno as its runtime and package manager;
  dependencies are tracked in `deno.lock`, and tasks live in `deno.json`).

## Commands

```bash
deno install          # install dependencies (reads package.json → node_modules + deno.lock)

deno task dev         # dev server on http://localhost:3000
deno task generate    # static build → .output/public
deno task preview     # preview a production build
```

Each task runs Nuxt **under the Deno runtime** (`deno run -A npm:nuxt …`) — there are
intentionally no `npm`/node scripts in `package.json`.

Deploy the generated `.output/public` directory to any static host.

## Contact form → Discord

The contact modal sends submissions to a Discord channel webhook.

1. In Discord: **Server Settings → Integrations → Webhooks → New Webhook → Copy Webhook URL**.
2. Copy `.env.example` to `.env` and set the URL:

   ```bash
   NUXT_PUBLIC_DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/XXX/YYY
   ```

3. Rebuild (`deno task generate`). Submissions arrive in the channel as an embed
   (name, email, message).

If the variable is empty, the form still works but only simulates a successful send.

### Heads-up: the webhook URL is public

This is a static site, so the webhook URL is baked into the client bundle and is publicly
visible — that is inherent to a client-side webhook. The form includes lightweight bot
mitigation (a honeypot field + a submit time-trap), but these stop casual bots, not someone
reading the JavaScript. If the webhook is ever abused, just **regenerate it in Discord**, or
move the call behind a small serverless proxy (e.g. a Cloudflare Worker) later — the UI
won't need to change.
