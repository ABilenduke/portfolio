<script setup lang="ts">
import { Mail } from 'lucide-vue-next'

const { open: openContact } = useContactModal()

const rows = [
  { k: 'Role', v: 'Senior software engineer' },
  { k: 'Currently', v: 'ITR Economics / Crowe' },
  { k: 'Stack', v: 'Vue 3 · Nuxt · Laravel · Azure' },
  { k: 'Based in', v: 'New England · open to relocation' },
]
</script>

<template>
  <section id="about" class="section bg-alt">
    <div class="container">
      <div class="about-grid">
        <div>
          <span class="eyebrow about__eyebrow">06 — about</span>
          <h2 class="h2 about__title">Hello — I'm Andrew.</h2>
          <p class="body-p about__lead">
            I'm a senior full-stack engineer with 11+ years building production web applications,
            with deep Vue.js and modern JavaScript expertise. I've made a habit of being the
            engineer who fixes what's broken — modernizing legacy codebases, hardening security,
            leading WCAG/ADA accessibility, and standing up CI/CD, testing, and DevOps where none
            existed.
          </p>
          <p class="body-p about__p">
            Based in New England, open to relocation. Studied full-stack development at Durham
            College in Oshawa, ON, graduating with honors in 2015.
          </p>
          <div class="about__actions">
            <button type="button" class="btn btn-secondary" @click="openContact()">
              <Mail :size="15" />
              Contact me
            </button>
          </div>
        </div>

        <div class="card about-card">
          <div class="about-card__media">
            <img
              src="/assets/andrew.jpg"
              alt="Andrew Bilenduke"
              class="about-card__img"
              width="640"
              height="480"
              loading="lazy"
            />
            <div class="about-card__chip">
              <span class="about-card__chip-dot" />
              andrew · new england
            </div>
          </div>

          <div class="about-card__info">
            <div class="about-card__status">
              <span class="about-card__status-label">current</span>
              <span class="pill-status pill-live">accepting work</span>
            </div>

            <div
              v-for="(row, i) in rows"
              :key="row.k"
              class="about-card__row"
              :class="{ last: i === rows.length - 1 }"
            >
              <span class="about-card__row-k">{{ row.k }}</span>
              <span class="about-card__row-v">{{ row.v }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.about-grid {
  display: grid;
  grid-template-columns: minmax(0, 1.1fr) minmax(0, 1fr);
  gap: 64px;
  align-items: center;
}
.about__eyebrow { margin-bottom: 18px; }
.about__title { margin-top: 18px; }
.about__lead {
  margin-top: 14px;
  font-size: 17px;
}
.about__p { margin-top: 14px; }
.about__actions {
  display: flex;
  gap: 12px;
  margin-top: 28px;
  flex-wrap: wrap;
}

.about-card {
  padding: 0;
  background: var(--bg-surface);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}
.about-card__media {
  position: relative;
  aspect-ratio: 4 / 3;
  background: var(--bg-tint);
  overflow: hidden;
}
.about-card__img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center 30%;
  display: block;
}
.about-card__chip {
  position: absolute;
  left: 16px;
  bottom: 16px;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 6px 10px;
  border-radius: var(--radius-pill);
  background: rgba(15, 23, 42, 0.72);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  font-family: var(--font-mono);
  font-size: 11.5px;
  color: rgba(255, 255, 255, 0.92);
  letter-spacing: 0.04em;
}
.about-card__chip-dot {
  width: 7px;
  height: 7px;
  border-radius: var(--radius-pill);
  background: var(--success);
  box-shadow: 0 0 0 3px rgba(25, 135, 84, 0.28);
}

.about-card__info {
  padding: 28px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.about-card__status {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-bottom: 14px;
  border-bottom: 1px solid var(--border-1);
}
.about-card__status-label {
  font-family: var(--font-mono);
  font-size: 12px;
  color: var(--fg-3);
  letter-spacing: 0.06em;
  text-transform: lowercase;
}
.about-card__row {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  gap: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid var(--border-1);
}
.about-card__row.last {
  padding-bottom: 0;
  border-bottom: none;
}
.about-card__row-k {
  font-family: var(--font-mono);
  font-size: 12.5px;
  color: var(--fg-3);
  letter-spacing: 0.04em;
}
.about-card__row-v {
  font-family: var(--font-body);
  font-size: 14px;
  color: var(--fg-1);
  font-weight: 500;
  text-align: right;
}

@media (max-width: 880px) {
  .about-grid {
    grid-template-columns: 1fr;
    gap: 32px;
  }
}
</style>
