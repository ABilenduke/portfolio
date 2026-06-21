<script setup lang="ts">
import { Sun, Moon } from 'lucide-vue-next'

const colorMode = useColorMode()
const isDark = computed(() => colorMode.value === 'dark')

function toggle() {
  colorMode.preference = isDark.value ? 'light' : 'dark'
}
</script>

<template>
  <button
    type="button"
    class="theme-toggle"
    :aria-label="isDark ? 'Switch to light theme' : 'Switch to dark theme'"
    :title="isDark ? 'Switch to light theme' : 'Switch to dark theme'"
    @click="toggle"
  >
    <!-- Render the icon only on the client to avoid a hydration mismatch
         (the resolved theme isn't known during SSG prerender). -->
    <ClientOnly>
      <Moon v-if="!isDark" :size="16" />
      <Sun v-else :size="16" />
      <template #fallback>
        <span class="theme-toggle__ph" aria-hidden="true" />
      </template>
    </ClientOnly>
  </button>
</template>

<style scoped>
.theme-toggle {
  width: 36px;
  height: 36px;
  display: inline-grid;
  place-items: center;
  border-radius: var(--radius-pill);
  border: 1px solid var(--border-2);
  background: var(--bg-surface);
  color: var(--fg-1);
  cursor: pointer;
  transition: background var(--dur-fast) var(--ease-out),
              border-color var(--dur-fast) var(--ease-out),
              color var(--dur-fast) var(--ease-out);
}
.theme-toggle:hover {
  border-color: var(--border-strong);
  color: var(--brand);
}
.theme-toggle__ph {
  width: 16px;
  height: 16px;
}
</style>
