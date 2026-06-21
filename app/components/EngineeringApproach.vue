<script setup lang="ts">
import { Wrench, Accessibility, TestTube, Container, ShieldCheck, Users } from 'lucide-vue-next'

const principles = [
  {
    icon: Wrench,
    title: "Fix what's broken",
    body: "I'm comfortable being the engineer who walks into a years-outdated codebase, a stalled migration, or a Veracode scan full of red — and quietly drives it green.",
  },
  {
    icon: Accessibility,
    title: 'Accessibility from the start',
    body: 'WCAG 2.1 AA, ARIA, screen reader compatibility, keyboard navigation. I led full ADA remediation at Lole following a lawsuit; I bake it in everywhere since.',
  },
  {
    icon: TestTube,
    title: 'Build the testing culture',
    body: 'Vitest, Pest, Playwright, Sauce Labs — I\'ve stood up CI-integrated test pipelines from zero, lifting meaningful coverage from ~3% to ~38% on a real codebase.',
  },
  {
    icon: Container,
    title: 'Dockerized and reproducible',
    body: "Docker, Docker Compose, Bash tooling. New developer onboarding from 1–2 days of environment setup to under an hour. The phrase 'works on my machine' doesn't get to live here.",
  },
  {
    icon: ShieldCheck,
    title: 'Security-minded development',
    body: 'Veracode remediation to 100%, OWASP awareness, dependency hardening, supply-chain considerations. Boring, predictable releases — not heroic 3 a.m. guesswork.',
  },
  {
    icon: Users,
    title: 'Mentorship that compounds',
    body: 'I mentor 3–4 developers at a time on Vue, testing, Docker workflows, and code review standards. Lead peer review. Architectural decisions made out loud.',
  },
]

const pad = (n: number) => String(n).padStart(2, '0')
</script>

<template>
  <section id="approach" class="section bg-tinted approach">
    <div class="container">
      <div class="section-head">
        <div class="left">
          <span class="eyebrow approach__eyebrow">02 — how I work</span>
          <h2 class="h2 approach__title">
            The engineer who fixes what's broken and builds the foundation a team can grow on.
          </h2>
          <p class="body-p approach__intro">
            These aren't slogans on a wall — they're the trade-offs I make every day. Modernizing
            legacy codebases, hardening security, leading accessibility, and standing up CI/CD where
            none existed.
          </p>
        </div>
      </div>

      <div class="approach__grid">
        <div v-for="(p, i) in principles" :key="p.title" class="card approach-card">
          <div class="approach-card__top">
            <div class="approach-card__icon">
              <component :is="p.icon" :size="20" />
            </div>
            <span class="approach-card__num">{{ pad(i + 1) }}</span>
          </div>
          <h4 class="h4 approach-card__title">{{ p.title }}</h4>
          <p class="approach-card__body">{{ p.body }}</p>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.approach { padding: 112px 0; }
.approach__eyebrow { margin-bottom: 18px; }
.approach__title { margin-top: 18px; }
.approach__intro { margin-top: 10px; }

.approach__grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 16px;
}
.approach-card {
  display: flex;
  flex-direction: column;
  gap: 14px;
  background: var(--bg-surface);
}
.approach-card__top {
  display: flex;
  align-items: center;
  gap: 14px;
}
.approach-card__icon {
  width: 40px;
  height: 40px;
  border-radius: var(--radius-md);
  background: var(--bg-tint);
  border: 1px solid var(--border-brand);
  display: grid;
  place-items: center;
  color: var(--brand);
}
.approach-card__num {
  font-family: var(--font-mono);
  font-size: 11px;
  color: var(--fg-3);
  letter-spacing: 0.08em;
}
.approach-card__title { margin-top: 4px; }
.approach-card__body {
  margin: 0;
  font-size: 14.5px;
  line-height: 1.6;
  color: var(--fg-2);
}
</style>
