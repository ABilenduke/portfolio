<script setup lang="ts">
import { Layout, Server, Cloud, ShieldCheck, Check } from 'lucide-vue-next'

const groups = [
  {
    title: 'Frontend',
    icon: Layout,
    items: ['Vue 3 (Composition API)', 'Nuxt 4', 'Inertia.js · Pinia', 'TypeScript · ES6+', 'PostCSS · SCSS/Sass', 'Design tokens · container queries'],
  },
  {
    title: 'Backend',
    icon: Server,
    items: ['PHP · Laravel', 'Filament · Livewire', 'Python · Flask', 'Node.js · Deno', 'REST APIs', 'PostgreSQL · MySQL · Redis · MongoDB'],
  },
  {
    title: 'DevOps & Infrastructure',
    icon: Cloud,
    items: ['Docker · Docker Compose', 'Bash scripting', 'nginx', 'Azure (dev/staging/prod)', 'GitHub Actions · CI/CD', 'Linux · WSL2'],
  },
  {
    title: 'Quality & Security',
    icon: ShieldCheck,
    items: ['WCAG 2.1 AA · ADA · ARIA', 'Vitest · Pest · Playwright', 'Sauce Labs · E2E', 'Veracode remediation', 'OWASP awareness', 'SOLID · PSR · PEP 8'],
  },
]
</script>

<template>
  <section id="stack" class="section">
    <div class="container">
      <div class="section-head">
        <div class="left">
          <span class="eyebrow stack__eyebrow">03 — technology</span>
          <h2 class="h2 stack__title">The tools I reach for.</h2>
          <p class="body-p stack__intro">
            Frontend, backend, infrastructure, and quality work — across 11+ years of production
            codebases.
          </p>
        </div>
      </div>

      <div class="stack__grid">
        <div v-for="g in groups" :key="g.title" class="card stack-card">
          <div class="stack-card__head">
            <div class="stack-card__icon">
              <component :is="g.icon" :size="18" />
            </div>
            <h4 class="h4">{{ g.title }}</h4>
          </div>
          <div class="stack-card__list">
            <div v-for="(it, i) in g.items" :key="it" class="stack-card__row" :class="{ first: i === 0 }">
              <span>{{ it }}</span>
              <Check :size="13" class="stack-card__check" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.stack__eyebrow { margin-bottom: 18px; }
.stack__title { margin-top: 18px; }
.stack__intro { margin-top: 10px; }

.stack__grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 24px;
}
.stack-card {
  display: flex;
  flex-direction: column;
  gap: 18px;
}
.stack-card__head {
  display: flex;
  align-items: center;
  gap: 12px;
}
.stack-card__icon {
  width: 36px;
  height: 36px;
  border-radius: var(--radius-md);
  background: var(--fg-1);
  color: var(--bg-page);
  display: grid;
  place-items: center;
}
.stack-card__list {
  display: flex;
  flex-direction: column;
}
.stack-card__row {
  padding: 12px 0;
  border-bottom: 1px solid var(--border-1);
  font-family: var(--font-mono);
  font-size: 12.5px;
  color: var(--fg-2);
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
}
.stack-card__row.first {
  border-top: 1px solid var(--border-1);
}
.stack-card__check {
  color: var(--brand);
  flex-shrink: 0;
}
</style>
