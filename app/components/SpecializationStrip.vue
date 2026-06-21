<script setup lang="ts">
import {
  Layout, Server, Container, Cloud,
  Accessibility, ShieldCheck, TestTube, Users,
} from 'lucide-vue-next'

const items = [
  { icon: Layout, label: 'Vue 3 & Nuxt 4' },
  { icon: Server, label: 'Laravel & Filament' },
  { icon: Container, label: 'Docker & CI/CD' },
  { icon: Cloud, label: 'Azure Pipelines' },
  { icon: Accessibility, label: 'WCAG / ADA' },
  { icon: ShieldCheck, label: 'Veracode / OWASP' },
  { icon: TestTube, label: 'Vitest · Pest · Playwright' },
  { icon: Users, label: 'Mentorship & Code Review' },
]
</script>

<template>
  <section class="strip">
    <div class="container">
      <div class="strip__head">
        <span class="strip__label">specializations</span>
        <span class="strip__meta">full-stack · frontend focus</span>
      </div>
      <div class="strip__grid">
        <div v-for="it in items" :key="it.label" class="strip__item">
          <div class="strip__icon">
            <component :is="it.icon" :size="18" />
          </div>
          <span class="strip__text">{{ it.label }}</span>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.strip {
  padding: 32px 0 56px;
  border-top: 1px solid var(--border-1);
  border-bottom: 1px solid var(--border-1);
  background: var(--bg-surface);
}
.strip__head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 16px;
}
.strip__label {
  font-family: var(--font-mono);
  font-size: 12px;
  color: var(--fg-3);
  letter-spacing: 0.08em;
  text-transform: lowercase;
}
.strip__meta {
  font-family: var(--font-mono);
  font-size: 12px;
  color: var(--fg-4);
}

/* Deterministic 4-up grid so the dividers always land correctly (the source
   computed borders against a fixed 4 columns; the layout now guarantees it). */
.strip__grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
}
.strip__item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px 18px 16px 0;
  border-right: 1px solid var(--border-1);
  border-bottom: 1px solid var(--border-1);
}
/* 4 cols: no right border on the last column, no bottom border on the last row. */
.strip__item:nth-child(4n) { border-right: none; }
.strip__item:nth-last-child(-n+4) { border-bottom: none; }

/* 2 cols */
@media (max-width: 720px) {
  .strip__grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .strip__item:nth-child(4n) { border-right: 1px solid var(--border-1); }
  .strip__item:nth-child(2n) { border-right: none; }
  .strip__item:nth-last-child(-n+4) { border-bottom: 1px solid var(--border-1); }
  .strip__item:nth-last-child(-n+2) { border-bottom: none; }
}

/* 1 col */
@media (max-width: 440px) {
  .strip__grid { grid-template-columns: 1fr; }
  .strip__item { border-right: none; }
  .strip__item:nth-child(2n) { border-right: none; }
  .strip__item:nth-last-child(-n+4) { border-bottom: 1px solid var(--border-1); }
  .strip__item:nth-last-child(-n+2) { border-bottom: 1px solid var(--border-1); }
  .strip__item:last-child { border-bottom: none; }
}
.strip__icon {
  width: 36px;
  height: 36px;
  border-radius: 8px;
  background: var(--bg-tint);
  border: 1px solid var(--border-brand);
  display: grid;
  place-items: center;
  color: var(--brand);
  flex-shrink: 0;
}
.strip__text {
  font-family: var(--font-body);
  font-size: 14px;
  font-weight: 500;
  color: var(--fg-1);
  letter-spacing: -0.005em;
}
</style>
