<script setup lang="ts">
import { ArrowRight, Lock, ExternalLink, Github } from 'lucide-vue-next'

const stacks = [
  { label: 'Public site', stack: ['Nuxt 4', 'Vue 3', 'TypeScript', 'Deno', 'PostCSS', 'Stripe'] },
  { label: 'Admin (isolated subdomain)', stack: ['Laravel', 'Filament', 'Livewire', 'PostgreSQL', 'Redis', 'nginx'] },
  { label: 'Tests & CI', stack: ['Vitest', 'Pest', 'Playwright', 'Lighthouse CI', 'GitHub Actions'] },
]

const facts = [
  { k: 'Frontend tests', v: 'Vitest', sub: 'components & composables' },
  { k: 'Backend tests', v: 'Pest', sub: 'feature · integration · admin permission matrices' },
  { k: 'E2E coverage', v: 'Playwright', sub: 'a11y · navigation · purchase · responsive · SEO · smoke' },
  { k: 'Design system', v: 'Cinematic Void', sub: 'editorial type · tokens · WCAG 2.1 AA' },
]
</script>

<template>
  <section id="projects" class="section">
    <div class="container">
      <div class="section-head">
        <div class="left">
          <span class="eyebrow fc__eyebrow">01 — featured project</span>
          <h2 class="h2 fc__title">The Final Cut.</h2>
          <p class="body-p fc__intro">
            A premium two-location movie theater web platform built end-to-end as a portfolio
            piece. Every architectural decision — public site, isolated admin, test pyramid,
            design system — made deliberately and documented.
          </p>
        </div>
        <a href="https://thefinalcut.andrewbilenduke.com" class="link-arrow">
          Visit live site
          <ArrowRight :size="14" />
        </a>
      </div>

      <article class="card fc-card">
        <!-- Browser chrome -->
        <div class="fc-chrome">
          <div class="fc-chrome__bar">
            <span class="fc-chrome__dot" />
            <span class="fc-chrome__dot" />
            <span class="fc-chrome__dot" />
            <div class="fc-chrome__url">
              <Lock :size="11" />
              thefinalcut.andrewbilenduke.com
            </div>
          </div>
        </div>

        <!-- "Cinematic Void" preview band -->
        <div class="fc-preview">
          <div class="fc-preview__grid" aria-hidden="true" />
          <div class="fc-preview__badge">
            <span class="pill-status pill-live">live demo</span>
          </div>
          <div class="fc-preview__copy">
            <div class="fc-preview__name">The Final Cut</div>
            <div class="fc-preview__sub">cinematic void · two-location theater platform</div>
          </div>
        </div>

        <!-- Body -->
        <div class="fc-body">
          <div>
            <div class="fc-body__kicker">portfolio · end-to-end</div>
            <h3 class="h3 fc-body__title">Premium movie theater web platform.</h3>
          </div>

          <p class="fc-body__desc">
            Public site covers schedule browsing, movie detail, multi-step seat selection with
            hold timers, food &amp; beverage add-ons, and Stripe checkout. A separate
            Filament/Livewire admin handles bookings, cancellations, schedule planning, gift
            cards, promo codes, and loyalty — isolated at three layers (nginx vhost + IP
            allowlist, Laravel route-domain scoping, separate Redis session DB).
          </p>

          <div class="fc-stacks">
            <div v-for="block in stacks" :key="block.label" class="fc-stack">
              <div class="fc-stack__label">{{ block.label }}</div>
              <div class="fc-stack__pills">
                <span v-for="s in block.stack" :key="s" class="pill">{{ s }}</span>
              </div>
            </div>
          </div>

          <div class="fc-facts">
            <div v-for="f in facts" :key="f.k" class="fc-fact">
              <div class="fc-fact__k">{{ f.k }}</div>
              <div class="fc-fact__v">{{ f.v }}</div>
              <div class="fc-fact__sub">{{ f.sub }}</div>
            </div>
          </div>

          <div class="fc-actions">
            <a class="btn btn-primary btn-sm" href="https://thefinalcut.andrewbilenduke.com">
              <ExternalLink :size="13" />
              Visit thefinalcut.andrewbilenduke.com
            </a>
            <a class="btn btn-ghost btn-sm fc-actions__ghost" href="https://github.com/ABilenduke/final-cut">
              <Github :size="13" />
              github.com/ABilenduke/final-cut
            </a>
          </div>
        </div>
      </article>
    </div>
  </section>
</template>

<style scoped>
.fc__eyebrow { margin-bottom: 18px; }
.fc__title { margin-top: 18px; }
.fc__intro { margin-top: 10px; }

.fc-card {
  display: flex;
  flex-direction: column;
  padding: 0;
  overflow: hidden;
}

/* Browser chrome */
.fc-chrome {
  background: var(--ink-900);
  padding: 10px 14px 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}
.fc-chrome__bar {
  display: flex;
  align-items: center;
  gap: 8px;
  padding-bottom: 10px;
}
.fc-chrome__dot {
  width: 10px;
  height: 10px;
  border-radius: var(--radius-pill);
  background: rgba(255, 255, 255, 0.2);
}
.fc-chrome__url {
  flex: 1;
  margin-left: 10px;
  padding: 5px 12px;
  border-radius: var(--radius-sm);
  background: rgba(255, 255, 255, 0.08);
  font-family: var(--font-mono);
  font-size: 11.5px;
  color: rgba(255, 255, 255, 0.65);
  display: flex;
  align-items: center;
  gap: 6px;
}

/* Preview band */
.fc-preview {
  height: 180px;
  background:
    radial-gradient(ellipse 70% 90% at 30% 30%, rgba(94, 135, 241, 0.18) 0%, transparent 60%),
    linear-gradient(135deg, #060a17 0%, #0f172a 60%, #1a2b66 110%);
  position: relative;
  border-bottom: 1px solid var(--border-1);
  overflow: hidden;
}
.fc-preview__grid {
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(rgba(255, 255, 255, 0.05) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
  background-size: 32px 32px;
  -webkit-mask-image: radial-gradient(ellipse 60% 80% at 75% 50%, #000 30%, transparent 75%);
          mask-image: radial-gradient(ellipse 60% 80% at 75% 50%, #000 30%, transparent 75%);
}
.fc-preview__badge {
  position: absolute;
  top: 16px;
  right: 16px;
}
.fc-preview__copy {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding-left: 32px;
}
.fc-preview__name {
  font-family: var(--font-display);
  font-weight: 700;
  font-size: 28px;
  letter-spacing: -0.02em;
  color: #fff;
  line-height: 1;
}
.fc-preview__sub {
  font-family: var(--font-mono);
  font-size: 12px;
  color: rgba(255, 255, 255, 0.55);
  margin-top: 8px;
  letter-spacing: 0.06em;
  text-transform: lowercase;
}

/* Body */
.fc-body {
  padding: 32px;
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.fc-body__kicker {
  font-family: var(--font-mono);
  font-size: 11.5px;
  letter-spacing: 0.08em;
  text-transform: lowercase;
  color: var(--brand);
  font-weight: 500;
  margin-bottom: 8px;
}
.fc-body__title { font-size: 26px; }
.fc-body__desc {
  font-size: 15px;
  line-height: 1.65;
  color: var(--fg-2);
  margin: 0;
  max-width: 70ch;
}

.fc-stacks {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 20px;
  padding-top: 8px;
}
.fc-stack__label {
  font-family: var(--font-mono);
  font-size: 11px;
  letter-spacing: 0.08em;
  text-transform: lowercase;
  color: var(--fg-3);
  margin-bottom: 10px;
}
.fc-stack__pills {
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
}

.fc-facts {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 16px;
  padding: 20px;
  background: var(--bg-sunk);
  border-radius: 12px;
  border: 1px solid var(--border-1);
}
.fc-fact__k {
  font-family: var(--font-mono);
  font-size: 11px;
  color: var(--fg-3);
  letter-spacing: 0.06em;
  text-transform: lowercase;
  margin-bottom: 4px;
}
.fc-fact__v {
  font-family: var(--font-display);
  font-weight: 600;
  font-size: 16px;
  color: var(--fg-1);
  letter-spacing: -0.008em;
}
.fc-fact__sub {
  font-size: 12.5px;
  color: var(--fg-3);
  margin-top: 3px;
  line-height: 1.45;
}

.fc-actions {
  display: flex;
  gap: 10px;
  padding-top: 18px;
  border-top: 1px solid var(--border-1);
  flex-wrap: wrap;
}
.fc-actions__ghost { color: var(--fg-2); }
</style>
