<script setup lang="ts">
import { Github, Linkedin, ArrowRight, Menu, X } from 'lucide-vue-next'

const { open } = useContactModal()

const links = [
  { id: 'projects', label: 'The Final Cut' },
  { id: 'outcomes', label: 'Outcomes' },
  { id: 'experience', label: 'Experience' },
  { id: 'about', label: 'About' },
]

const scrolled = ref(false)
const menuOpen = ref(false)

function onScroll() {
  scrolled.value = window.scrollY > 8
}
function onKey(e: KeyboardEvent) {
  if (e.key === 'Escape') menuOpen.value = false
}
function onResize() {
  if (window.innerWidth >= 880) menuOpen.value = false
}
function contactFromMenu() {
  menuOpen.value = false
  open()
}

onMounted(() => {
  window.addEventListener('scroll', onScroll, { passive: true })
  window.addEventListener('keydown', onKey)
  window.addEventListener('resize', onResize)
  onScroll()
})
onBeforeUnmount(() => {
  window.removeEventListener('scroll', onScroll)
  window.removeEventListener('keydown', onKey)
  window.removeEventListener('resize', onResize)
})
</script>

<template>
  <header class="site-header" :class="{ scrolled, 'menu-open': menuOpen }">
    <div class="container site-header__inner">
      <a href="#top" class="brand" @click="menuOpen = false">
        <div class="brand__mark">A</div>
        <div class="brand__text">
          <span class="brand__name">Andrew Bilenduke</span>
          <span class="brand__role">senior full-stack engineer</span>
        </div>
      </a>

      <nav class="site-nav" aria-label="Primary">
        <a v-for="l in links" :key="l.id" :href="`#${l.id}`" class="site-nav__link">
          {{ l.label }}
        </a>
      </nav>

      <div class="site-header__actions">
        <ThemeToggle />

        <!-- Desktop: inline social + contact -->
        <div class="site-header__desktop">
          <a
            class="btn btn-ghost btn-sm site-header__social"
            href="https://github.com/ABilenduke"
            aria-label="GitHub"
          >
            <Github :size="16" />
            <span>GitHub</span>
          </a>
          <a
            class="btn btn-ghost btn-sm site-header__social"
            href="https://www.linkedin.com/in/andrew-bilenduke-8633118a"
            target="_blank"
            rel="noopener noreferrer"
            aria-label="LinkedIn"
          >
            <Linkedin :size="16" />
            <span>LinkedIn</span>
          </a>
          <button type="button" class="btn btn-dark btn-sm site-header__contact" @click="open()">
            Contact
            <ArrowRight :size="14" />
          </button>
        </div>

        <!-- Mobile: hamburger -->
        <button
          type="button"
          class="site-header__menu-btn"
          :aria-expanded="menuOpen"
          aria-controls="mobile-menu"
          :aria-label="menuOpen ? 'Close menu' : 'Open menu'"
          @click="menuOpen = !menuOpen"
        >
          <Menu v-if="!menuOpen" :size="20" />
          <X v-else :size="20" />
        </button>
      </div>
    </div>

    <!-- Mobile menu panel -->
    <Transition name="menu">
      <nav v-if="menuOpen" id="mobile-menu" class="mobile-menu" aria-label="Mobile">
        <a
          v-for="l in links"
          :key="l.id"
          :href="`#${l.id}`"
          class="mobile-menu__link"
          @click="menuOpen = false"
        >
          {{ l.label }}
        </a>
        <div class="mobile-menu__divider" />
        <a
          class="mobile-menu__link mobile-menu__link--icon"
          href="https://github.com/ABilenduke"
          @click="menuOpen = false"
        >
          <Github :size="17" />
          GitHub
        </a>
        <a
          class="mobile-menu__link mobile-menu__link--icon"
          href="https://www.linkedin.com/in/andrew-bilenduke-8633118a"
          target="_blank"
          rel="noopener noreferrer"
          @click="menuOpen = false"
        >
          <Linkedin :size="17" />
          LinkedIn
        </a>
        <button type="button" class="btn btn-dark mobile-menu__contact" @click="contactFromMenu">
          Contact
          <ArrowRight :size="15" />
        </button>
      </nav>
    </Transition>
  </header>
</template>

<style scoped>
.site-header {
  position: sticky;
  top: 0;
  z-index: var(--z-sticky);
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
  border-bottom: 1px solid transparent;
  transition: background var(--dur-base) var(--ease-out),
              border-color var(--dur-base) var(--ease-out);
}
.site-header.scrolled,
.site-header.menu-open {
  background: rgba(255, 255, 255, 0.82);
  border-bottom-color: var(--border-1);
}
[data-theme="dark"] .site-header {
  background: rgba(11, 18, 34, 0.55);
}
[data-theme="dark"] .site-header.scrolled,
[data-theme="dark"] .site-header.menu-open {
  background: rgba(11, 18, 34, 0.78);
}

.site-header__inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 72px;
  gap: 16px;
}

/* Brand */
.brand {
  display: flex;
  align-items: center;
  gap: 12px;
  text-decoration: none;
  min-width: 0;
}
.brand__mark {
  flex-shrink: 0;
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
.brand__text {
  display: flex;
  flex-direction: column;
  line-height: 1.1;
  min-width: 0;
}
.brand__name {
  font-family: var(--font-display);
  font-weight: 700;
  font-size: 15px;
  color: var(--fg-1);
  letter-spacing: -0.012em;
  white-space: nowrap;
}
.brand__role {
  font-family: var(--font-mono);
  font-size: 11px;
  color: var(--fg-3);
  letter-spacing: 0.04em;
  white-space: nowrap;
}

/* Nav */
.site-nav {
  display: flex;
  align-items: center;
  gap: 28px;
}
.site-nav__link {
  font-family: var(--font-body);
  font-size: 14px;
  font-weight: 500;
  color: var(--fg-2);
  text-decoration: none;
  padding: 6px 2px;
  transition: color var(--dur-fast) var(--ease-out);
}
.site-nav__link:hover {
  color: var(--fg-1);
}

/* Actions */
.site-header__actions {
  display: flex;
  align-items: center;
  gap: 10px;
  flex-shrink: 0;
}
.site-header__desktop {
  display: flex;
  align-items: center;
  gap: 10px;
}
.site-header__social {
  color: var(--fg-2);
}
.site-header__contact {
  border-radius: var(--radius-pill);
  padding: 10px 16px;
}

/* Hamburger (mobile only) */
.site-header__menu-btn {
  display: none;
  width: 40px;
  height: 40px;
  place-items: center;
  border-radius: var(--radius-md);
  border: 1px solid var(--border-2);
  background: var(--bg-surface);
  color: var(--fg-1);
  cursor: pointer;
  transition: border-color var(--dur-fast) var(--ease-out), color var(--dur-fast) var(--ease-out);
}
.site-header__menu-btn:hover {
  border-color: var(--border-strong);
  color: var(--brand);
}

/* Mobile menu panel */
.mobile-menu {
  display: flex;
  flex-direction: column;
  gap: 2px;
  padding: 12px 24px 20px;
  background: var(--bg-surface);
  border-top: 1px solid var(--border-1);
}
.mobile-menu__link {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 13px 8px;
  font-family: var(--font-body);
  font-size: 16px;
  font-weight: 500;
  color: var(--fg-1);
  text-decoration: none;
  border-radius: var(--radius-sm);
}
.mobile-menu__link:hover {
  background: var(--bg-sunk);
  color: var(--brand);
}
.mobile-menu__link--icon {
  color: var(--fg-2);
  font-size: 15px;
}
.mobile-menu__divider {
  height: 1px;
  background: var(--border-1);
  margin: 8px 0;
}
.mobile-menu__contact {
  margin-top: 10px;
  justify-content: center;
  border-radius: var(--radius-pill);
  width: 100%;
  padding: 13px 18px;
}

.menu-enter-active,
.menu-leave-active {
  transition: opacity var(--dur-base) var(--ease-out), transform var(--dur-base) var(--ease-out);
}
.menu-enter-from,
.menu-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}

/* Breakpoint: collapse to hamburger under 880px */
@media (max-width: 880px) {
  .site-nav { display: none; }
  .site-header__desktop { display: none; }
  .site-header__menu-btn { display: inline-grid; }
}
</style>
