<script setup lang="ts">
import { Mail, Github, Linkedin } from 'lucide-vue-next'

const { open: openContact } = useContactModal()
</script>

<template>
  <section id="contact" class="section cta">
    <div class="container">
      <div class="cta-panel bg-codegrid">
        <div class="cta-panel__inner">
          <span class="cta__eyebrow">
            <span class="cta__eyebrow-line" />
            let's talk
          </span>
          <h2 class="cta__title">Have a legacy codebase that needs a steady hand?</h2>
          <p class="cta__lead">
            Vue/Nuxt frontend work, Laravel APIs, Dockerized deployments, accessibility
            remediation, security hardening, or testing infrastructure built from zero — I'd be
            glad to talk.
          </p>

          <div class="cta__actions">
            <button type="button" class="btn btn-primary" @click="openContact()">
              <Mail :size="16" />
              Contact me
            </button>
            <a href="https://github.com/ABilenduke" class="btn cta__btn-glass">
              <Github :size="16" />
              GitHub
            </a>
            <a
              href="https://www.linkedin.com/in/andrew-bilenduke-8633118a"
              target="_blank"
              rel="noopener noreferrer"
              class="btn cta__btn-glass"
            >
              <Linkedin :size="16" />
              LinkedIn
            </a>
          </div>

          <div class="cta__meta">
            <span>New England · open to relocation</span>
            <span>github.com/ABilenduke</span>
            <span>linkedin.com/in/andrew-bilenduke</span>
            <span>résumé on request</span>
          </div>
        </div>

        <div class="cta-panel__deco" aria-hidden="true" />
      </div>
    </div>
  </section>
</template>

<style scoped>
.cta {
  padding-top: 96px;
  padding-bottom: 96px;
}
.cta-panel {
  background: var(--ink-900);
  border-radius: var(--radius-2xl);
  padding: 72px 56px;
  color: #fff;
  position: relative;
  overflow: hidden;
}
.cta-panel__inner {
  position: relative;
  z-index: 2;
  max-width: 720px;
}
.cta__eyebrow {
  font-family: var(--font-mono);
  font-size: 13px;
  color: var(--blue-300);
  letter-spacing: 0.08em;
  text-transform: lowercase;
  display: inline-flex;
  align-items: center;
  gap: 10px;
}
.cta__eyebrow-line {
  display: inline-block;
  width: 28px;
  height: 1px;
  background: var(--blue-300);
}
.cta__title {
  font-family: var(--font-display);
  font-weight: 700;
  font-size: clamp(2rem, 1.4rem + 2vw, 3rem);
  line-height: 1.08;
  letter-spacing: -0.022em;
  color: #fff;
  text-wrap: balance;
  margin: 20px 0 0;
  max-width: 20ch;
}
.cta__lead {
  font-family: var(--font-body);
  font-size: 17px;
  line-height: 1.65;
  color: rgba(255, 255, 255, 0.74);
  margin: 20px 0 0;
  max-width: 60ch;
}
.cta__actions {
  display: flex;
  gap: 12px;
  margin-top: 36px;
  flex-wrap: wrap;
}
.cta__btn-glass {
  background: rgba(255, 255, 255, 0.08);
  color: #fff;
  border: 1px solid rgba(255, 255, 255, 0.18);
}
.cta__btn-glass:hover {
  background: rgba(255, 255, 255, 0.14);
}
.cta__meta {
  margin-top: 48px;
  padding-top: 28px;
  border-top: 1px solid rgba(255, 255, 255, 0.08);
  display: flex;
  gap: 32px;
  flex-wrap: wrap;
  font-family: var(--font-mono);
  font-size: 13px;
  color: rgba(255, 255, 255, 0.55);
}
.cta-panel__deco {
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(rgba(255, 255, 255, 0.04) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255, 255, 255, 0.04) 1px, transparent 1px);
  background-size: 40px 40px;
  -webkit-mask-image: radial-gradient(ellipse 60% 80% at 95% 30%, #000 30%, transparent 75%);
          mask-image: radial-gradient(ellipse 60% 80% at 95% 30%, #000 30%, transparent 75%);
  pointer-events: none;
  z-index: 1;
}

@media (max-width: 600px) {
  .cta {
    padding-top: 56px;
    padding-bottom: 56px;
  }
  .cta-panel {
    padding: 44px 24px;
    border-radius: var(--radius-xl);
  }
  .cta__title {
    font-size: clamp(1.75rem, 1.2rem + 3vw, 2.2rem);
  }
  .cta__meta {
    gap: 16px 24px;
  }
}
</style>
