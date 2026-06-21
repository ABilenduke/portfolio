<script setup lang="ts">
import { ArrowRight } from 'lucide-vue-next'
</script>

<template>
  <section id="top" class="hero bg-codegrid">
    <div class="container hero__grid">
      <div class="hero-copy">
        <span class="eyebrow hero__eyebrow">Andrew Bilenduke · New England · open to relocation</span>

        <h1 class="h-display hero__title">
          Senior full-stack engineer who fixes <span class="hero__title-accent">what's broken</span>
          and builds the foundation a team can grow on.
        </h1>

        <p class="lead hero__lead">
          11+ years shipping production web applications, with deep Vue.js and modern JavaScript
          expertise. I modernize legacy codebases, harden security, lead WCAG/ADA accessibility
          remediation, and stand up CI/CD, testing, and DevOps where none existed.
        </p>

        <div class="hero__actions">
          <a href="#projects" class="btn btn-primary">
            See The Final Cut
            <ArrowRight :size="16" />
          </a>
          <a href="#experience" class="btn btn-secondary">Experience &amp; outcomes</a>
          <a href="#contact" class="btn btn-ghost">Get in touch</a>
        </div>

        <div class="hero__meta">
          <span class="hero__status">
            <span class="hero__status-dot" />
            Open to new roles
          </span>
          <span class="hero__sep">·</span>
          <span>Remote · open to relocation</span>
          <span class="hero__sep">·</span>
          <span>Vue · Nuxt · Laravel · Azure</span>
        </div>
      </div>

      <!-- Terminal "system" panel -->
      <div class="hero-panel" aria-hidden="true">
        <div class="hero-panel__chrome">
          <span class="dot dot--red" />
          <span class="dot dot--amber" />
          <span class="dot dot--green" />
          <span class="hero-panel__path">~/itr-economics · deploy.sh</span>
        </div>
        <div class="hero-panel__screen">
          <div><span class="t-blue">$</span> deploy --env prod --azure</div>
          <div class="t-dim">→ docker build · cached layers</div>
          <div class="t-dim">→ pest + vitest <span class="t-green">847 passing</span></div>
          <div class="t-dim">→ playwright e2e <span class="t-green">15/15</span></div>
          <div class="t-dim">→ veracode scan <span class="t-green">100%</span></div>
          <div class="hero-panel__deployed">
            <span class="t-green">✓</span>
            <span class="t-white">deployed</span>
            <span class="t-dim2">· 38m 12s · 0 errors</span>
          </div>

          <div class="hero-panel__stats">
            <span>deploy time <span class="t-white">−70%</span></span>
            <span>page load <span class="t-white">−35%</span></span>
            <span>coverage <span class="t-white">3% → 38%</span></span>
            <span>onboarding <span class="t-green">&lt; 1hr</span></span>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.hero {
  padding-top: 88px;
  padding-bottom: 72px;
  position: relative;
}
.hero__grid {
  display: grid;
  grid-template-columns: minmax(0, 1fr) minmax(0, 440px);
  gap: 56px;
  align-items: center;
}
.hero__eyebrow { margin-bottom: 20px; }
.hero__title {
  margin-top: 22px;
  max-width: 18ch;
}
.hero__title-accent { color: var(--brand); }
.hero__lead {
  margin-top: 28px;
  max-width: 60ch;
}
.hero__actions {
  display: flex;
  gap: 12px;
  margin-top: 36px;
  flex-wrap: wrap;
}
.hero__meta {
  display: flex;
  align-items: center;
  gap: 18px;
  margin-top: 56px;
  font-family: var(--font-mono);
  font-size: 13px;
  color: var(--fg-3);
  flex-wrap: wrap;
}
.hero__status {
  display: inline-flex;
  align-items: center;
  gap: 8px;
}
.hero__status-dot {
  width: 8px;
  height: 8px;
  border-radius: var(--radius-pill);
  background: var(--success);
  box-shadow: 0 0 0 4px rgba(25, 135, 84, 0.18);
}
.hero__sep { color: var(--border-2); }

/* Terminal panel */
.hero-panel {
  background: var(--ink-900);
  border-radius: var(--radius-xl);
  padding: 4px;
  box-shadow: 0 28px 64px rgba(15, 23, 42, 0.18), 0 8px 16px rgba(15, 23, 42, 0.06);
  border: 1px solid rgba(255, 255, 255, 0.06);
  position: relative;
  z-index: 2;
}
.hero-panel__chrome {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 14px 10px;
}
.dot {
  width: 11px;
  height: 11px;
  border-radius: var(--radius-pill);
}
.dot--red { background: #ff5f57; }
.dot--amber { background: #febc2e; }
.dot--green { background: #28c840; }
.hero-panel__path {
  margin-left: 12px;
  font-family: var(--font-mono);
  font-size: 11px;
  color: rgba(255, 255, 255, 0.5);
  letter-spacing: 0.06em;
}
.hero-panel__screen {
  background: #060a17;
  border-radius: 16px;
  padding: 20px 22px 22px;
  font-family: var(--font-mono);
  font-size: 13px;
  line-height: 1.65;
  color: rgba(231, 236, 244, 0.92);
}
.t-blue { color: #5e87f1; }
.t-dim { color: rgba(231, 236, 244, 0.55); }
.t-dim2 { color: rgba(231, 236, 244, 0.5); }
.t-green { color: #28c840; }
.t-white { color: #fff; }
.hero-panel__deployed { margin-top: 10px; }
.hero-panel__stats {
  margin-top: 18px;
  padding-top: 14px;
  border-top: 1px solid rgba(255, 255, 255, 0.07);
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10px;
  font-size: 11.5px;
  color: rgba(231, 236, 244, 0.6);
}

@media (max-width: 980px) {
  .hero__grid { grid-template-columns: 1fr; }
  .hero-panel { display: none; }
}
</style>
