<script setup lang="ts">
const outcomes = [
  {
    metric: '−35%',
    label: 'page load improvement',
    body: 'Migrated a legacy Blade application to a full Vue 3 SPA using Inertia.js and Pinia — modernizing 50+ views and ~50k lines of code without a disruptive rewrite.',
    where: 'ITR Economics / Crowe',
  },
  {
    metric: '100%',
    label: 'veracode remediation',
    body: 'Drove Veracode security scan results to 100%, closing every finding across the codebase and bringing a years-outdated project current as part of a security audit.',
    where: 'ITR Economics / Crowe',
  },
  {
    metric: '3% → 38%',
    label: 'test coverage from zero',
    body: 'Established testing culture from zero. Vitest, Pest, and Playwright E2E. Integrated Playwright with Sauce Labs through CI. 15 critical user journeys under E2E.',
    where: 'ITR Economics / Crowe',
  },
  {
    metric: '2–4hr → 40m',
    label: 'deployment time (~70% reduction)',
    body: 'Rebuilt the deployment pipeline with Docker, Docker Compose, Bash tooling, and Azure across dev, staging, and production. Lifted release cadence from monthly to multiple deploys per week.',
    where: 'ITR Economics / Crowe',
  },
  {
    metric: '1–2 days → < 1hr',
    label: 'developer onboarding',
    body: 'Reduced new developer onboarding from 1–2 days of environment setup to under an hour through containerized local development.',
    where: 'ITR Economics / Crowe',
  },
  {
    metric: 'ADA compliant',
    label: 'post-lawsuit remediation',
    body: 'Led full accessibility remediation following an ADA-related lawsuit. Screen reader support, keyboard navigation including complex data tables, WCAG color contrast, and proper ARIA semantics.',
    where: 'Lole Brands',
  },
]
</script>

<template>
  <section id="outcomes" class="section bg-alt">
    <div class="container">
      <div class="section-head">
        <div class="left">
          <span class="eyebrow outcomes__eyebrow">04 — outcomes</span>
          <h2 class="h2 outcomes__title">Concrete numbers over adjectives.</h2>
          <p class="body-p outcomes__intro">
            A short selection of measurable outcomes from the last few years — most from a single
            engagement, modernizing a legacy codebase from the inside.
          </p>
        </div>
      </div>

      <div class="outcomes__grid">
        <div v-for="o in outcomes" :key="o.label" class="card outcome-card">
          <div class="outcome-card__metric">{{ o.metric }}</div>
          <div class="outcome-card__label">{{ o.label }}</div>
          <p class="outcome-card__body">{{ o.body }}</p>
          <div class="outcome-card__where">@ {{ o.where }}</div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.outcomes__eyebrow { margin-bottom: 18px; }
.outcomes__title { margin-top: 18px; }
.outcomes__intro { margin-top: 10px; }

.outcomes__grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 16px;
}
.outcome-card { background: var(--bg-surface); }
.outcome-card__metric {
  font-family: var(--font-display);
  font-weight: 700;
  font-size: 30px;
  letter-spacing: -0.02em;
  color: var(--fg-1);
  line-height: 1.05;
}
.outcome-card__label {
  font-family: var(--font-mono);
  font-size: 12px;
  color: var(--brand);
  letter-spacing: 0.06em;
  margin-top: 6px;
  text-transform: lowercase;
}
.outcome-card__body {
  margin-top: 14px;
  font-size: 14.5px;
  line-height: 1.6;
  color: var(--fg-2);
}
.outcome-card__where {
  font-family: var(--font-mono);
  font-size: 11.5px;
  color: var(--fg-3);
  letter-spacing: 0.04em;
  margin-top: 14px;
  padding-top: 12px;
  border-top: 1px solid var(--border-1);
}
</style>
