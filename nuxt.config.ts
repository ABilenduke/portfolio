// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  modules: [
    '@nuxt/fonts',
    '@nuxtjs/color-mode',
  ],

  // Global design system: tokens first, then site-level utility classes.
  css: [
    '~/assets/css/colors_and_type.css',
    '~/assets/css/site.css',
  ],

  // Theme is driven by `data-theme="light|dark"` on <html>.
  // color-mode injects the pre-paint script (no flash) and persists the choice.
  colorMode: {
    preference: 'system',
    fallback: 'light',
    dataValue: 'theme',
    classSuffix: '',
    storageKey: 'theme',
  },

  // Self-host webfonts at build time (no runtime CDN). Replaces the design's
  // @font-face TTFs / Google @import.
  fonts: {
    families: [
      { name: 'Sora', provider: 'google' },
      { name: 'Inter', provider: 'google' },
      { name: 'JetBrains Mono', provider: 'google' },
    ],
  },

  // Discord webhook URL is injected from NUXT_PUBLIC_DISCORD_WEBHOOK_URL.
  // It is public by nature (client-side POST) — see ContactModal for caveats.
  runtimeConfig: {
    public: {
      discordWebhookUrl: '',
    },
  },

  app: {
    head: {
      htmlAttrs: { lang: 'en' },
      link: [
        { rel: 'icon', type: 'image/svg+xml', href: '/assets/logo-ab.svg' },
        { rel: 'apple-touch-icon', href: '/assets/apple-touch-icon.png' },
      ],
    },
  },

  devtools: { enabled: true },
  compatibilityDate: '2024-04-03',
})
