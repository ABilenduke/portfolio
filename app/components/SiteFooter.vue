<script setup lang="ts">
const { open: openContact } = useContactModal()

const cols = [
  {
    title: 'Site',
    links: [
      { label: 'Home', href: '#top' },
      { label: 'The Final Cut', href: '#projects' },
      { label: 'Approach', href: '#approach' },
      { label: 'Stack', href: '#stack' },
      { label: 'Outcomes', href: '#outcomes' },
      { label: 'Experience', href: '#experience' },
      { label: 'About', href: '#about' },
    ],
  },
  {
    title: 'Featured',
    links: [
      { label: 'thefinalcut.andrewbilenduke.com', href: 'https://thefinalcut.andrewbilenduke.com' },
      { label: 'github.com/ABilenduke/final-cut', href: 'https://github.com/ABilenduke/final-cut' },
    ],
  },
  {
    title: 'Elsewhere',
    links: [
      { label: 'GitHub · @ABilenduke', href: 'https://github.com/ABilenduke' },
      { label: 'LinkedIn', href: 'https://www.linkedin.com/in/andrew-bilenduke-8633118a' },
      { label: 'Contact me', action: 'contact' as const },
    ],
  },
]
</script>

<template>
  <footer class="footer">
    <div class="container">
      <div class="footer-grid">
        <div>
          <a href="#top" class="footer-brand">
            <div class="footer-brand__mark">A</div>
            <span class="footer-brand__name">Andrew Bilenduke</span>
          </a>
          <p class="footer-brand__desc">
            Senior full-stack engineer · frontend focus. Vue, Nuxt, Laravel, Docker, Azure. New
            England — open to relocation.
          </p>
        </div>

        <div v-for="c in cols" :key="c.title" class="footer-col">
          <div class="footer-col__title">{{ c.title }}</div>
          <ul class="footer-col__list">
            <li v-for="l in c.links" :key="l.label">
              <button
                v-if="'action' in l && l.action === 'contact'"
                type="button"
                class="footer-link footer-link--btn"
                @click="openContact()"
              >
                {{ l.label }}
              </button>
              <a v-else class="footer-link" :href="l.href">{{ l.label }}</a>
            </li>
          </ul>
        </div>
      </div>

      <div class="footer-bottom">
        <span>© 2026 Andrew Bilenduke</span>
        <span>Built by hand. 11+ years of doing this.</span>
      </div>
    </div>
  </footer>
</template>

<style scoped>
.footer {
  border-top: 1px solid var(--border-1);
  background: var(--bg-surface);
  padding-top: 64px;
  padding-bottom: 32px;
}
.footer-grid {
  display: grid;
  grid-template-columns: 1.4fr 1fr 1fr 1fr;
  gap: 48px;
  padding-bottom: 56px;
}
.footer-brand {
  display: flex;
  align-items: center;
  gap: 12px;
  text-decoration: none;
}
.footer-brand__mark {
  width: 36px;
  height: 36px;
  border-radius: var(--radius-md);
  background: var(--fg-1);
  color: var(--bg-page);
  display: grid;
  place-items: center;
  font-family: var(--font-display);
  font-weight: 800;
  font-size: 18px;
  letter-spacing: -0.04em;
}
.footer-brand__name {
  font-family: var(--font-display);
  font-weight: 700;
  font-size: 16px;
  color: var(--fg-1);
  letter-spacing: -0.012em;
}
.footer-brand__desc {
  margin: 20px 0 0;
  font-size: 14px;
  line-height: 1.65;
  color: var(--fg-2);
  max-width: 36ch;
}

.footer-col__title {
  font-family: var(--font-mono);
  font-size: 11.5px;
  color: var(--fg-3);
  letter-spacing: 0.08em;
  text-transform: lowercase;
  margin-bottom: 16px;
}
.footer-col__list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.footer-link {
  color: var(--fg-1);
  text-decoration: none;
  font-size: 14px;
  transition: color var(--dur-fast) var(--ease-out);
}
.footer-link:hover {
  color: var(--brand);
}
.footer-link--btn {
  background: none;
  border: none;
  padding: 0;
  cursor: pointer;
  font-family: inherit;
  text-align: left;
}

.footer-bottom {
  padding-top: 24px;
  border-top: 1px solid var(--border-1);
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
  font-family: var(--font-mono);
  font-size: 12px;
  color: var(--fg-3);
}

@media (max-width: 880px) {
  .footer-grid {
    grid-template-columns: 1fr 1fr;
    gap: 32px;
  }
}
@media (max-width: 540px) {
  .footer-grid {
    grid-template-columns: 1fr;
  }
}
</style>
