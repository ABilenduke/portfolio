<script setup lang="ts">
import { X, Check, ArrowRight } from 'lucide-vue-next'

const { isOpen, close } = useContactModal()
const config = useRuntimeConfig()
const webhookUrl = config.public.discordWebhookUrl as string

type Status = 'idle' | 'sending' | 'sent' | 'error'
const status = ref<Status>('idle')

const name = ref('')
const email = ref('')
const message = ref('')
const honeypot = ref('') // bots fill this; humans never see it

const dialogRef = ref<HTMLElement | null>(null)
const firstFieldRef = ref<HTMLInputElement | null>(null)
const sentCloseBtnRef = ref<HTMLButtonElement | null>(null)

// Discord embed limits: field value 1024, description 4096, ~6000 total.
const NAME_MAX = 256
const MESSAGE_MAX = 3800

let openedAt = 0
let previouslyFocused: HTMLElement | null = null

function resetForm() {
  name.value = ''
  email.value = ''
  message.value = ''
  honeypot.value = ''
}

async function handleSubmit() {
  // Honeypot tripped → pretend success without sending (don't tip off bots).
  if (honeypot.value) {
    status.value = 'sent'
    resetForm()
    return
  }
  // Time-trap: a bot round-trips far faster than a human can read the form and
  // type a (required) message. Kept low so autofilled, fast users don't trip it.
  if (Date.now() - openedAt < 1200) {
    status.value = 'sent'
    resetForm()
    return
  }

  status.value = 'sending'
  try {
    if (webhookUrl) {
      const res = await fetch(webhookUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          username: 'Portfolio contact',
          embeds: [
            {
              title: 'New message from the portfolio',
              color: 0x3a64e3,
              fields: [
                { name: 'Name', value: (name.value || '—').slice(0, NAME_MAX), inline: true },
                { name: 'Email', value: (email.value || '—').slice(0, NAME_MAX), inline: true },
              ],
              description: (message.value || '—').slice(0, 4096),
              timestamp: new Date().toISOString(),
            },
          ],
        }),
      })
      if (!res.ok) throw new Error(`Discord webhook responded ${res.status}`)
    } else {
      // No webhook configured yet (NUXT_PUBLIC_DISCORD_WEBHOOK_URL empty) —
      // simulate a successful send so the UI is fully testable.
      await new Promise((r) => setTimeout(r, 700))
    }
    status.value = 'sent'
    resetForm()
  } catch {
    status.value = 'error'
  }
}

function onKeydown(e: KeyboardEvent) {
  if (e.key === 'Escape') {
    close()
    return
  }
  if (e.key !== 'Tab' || !dialogRef.value) return
  const focusables = Array.from(
    dialogRef.value.querySelectorAll<HTMLElement>(
      'a[href], button:not([disabled]), input:not([tabindex="-1"]), textarea, [tabindex]:not([tabindex="-1"])',
    ),
  ).filter((el) => el.offsetParent !== null)
  if (!focusables.length) return
  const first = focusables[0]
  const last = focusables[focusables.length - 1]
  if (e.shiftKey && document.activeElement === first) {
    e.preventDefault()
    last.focus()
  } else if (!e.shiftKey && document.activeElement === last) {
    e.preventDefault()
    first.focus()
  }
}

watch(isOpen, (open) => {
  if (open) {
    previouslyFocused = (document.activeElement as HTMLElement) ?? null
    openedAt = Date.now()
    document.body.style.overflow = 'hidden'
    document.addEventListener('keydown', onKeydown)
    nextTick(() => firstFieldRef.value?.focus())
  } else {
    document.body.style.overflow = ''
    document.removeEventListener('keydown', onKeydown)
    window.setTimeout(() => {
      status.value = 'idle'
    }, 250)
    previouslyFocused?.focus?.()
  }
})

// When the form is replaced by the success panel, move focus into it so a
// keyboard/SR user keeps their place (the panel is also role="status").
watch(status, (s) => {
  if (s === 'sent') nextTick(() => sentCloseBtnRef.value?.focus())
})

onBeforeUnmount(() => {
  document.removeEventListener('keydown', onKeydown)
  document.body.style.overflow = ''
})
</script>

<template>
  <Transition name="cm">
    <div
      v-if="isOpen"
      class="cm-overlay"
      role="dialog"
      aria-modal="true"
      aria-labelledby="cm-title"
      @mousedown.self="close()"
    >
      <div ref="dialogRef" class="card cm-card">
        <!-- Header -->
        <div class="cm-head">
          <div>
            <span class="cm-head__eyebrow">get in touch</span>
            <h3 id="cm-title" class="h3 cm-head__title">Send me a message</h3>
          </div>
          <button type="button" class="cm-close" aria-label="Close" @click="close()">
            <X :size="16" />
          </button>
        </div>

        <!-- Sent state -->
        <div v-if="status === 'sent'" class="cm-sent" role="status">
          <div class="cm-sent__icon">
            <Check :size="22" />
          </div>
          <h4 class="cm-sent__title">Thanks — message received.</h4>
          <p class="cm-sent__body">
            I'll get back to you within a couple of business days. Talk soon.
          </p>
          <button
            ref="sentCloseBtnRef"
            type="button"
            class="btn btn-secondary cm-sent__btn"
            @click="close()"
          >
            Close
          </button>
        </div>

        <!-- Form -->
        <form v-else class="cm-form" @submit.prevent="handleSubmit">
          <label class="cm-field">
            <span class="cm-field__label">name</span>
            <input
              ref="firstFieldRef"
              v-model="name"
              name="name"
              type="text"
              required
              :maxlength="NAME_MAX"
              autocomplete="name"
              class="cm-input"
              placeholder="Your name"
            />
          </label>

          <label class="cm-field">
            <span class="cm-field__label">email</span>
            <input
              v-model="email"
              name="email"
              type="email"
              required
              :maxlength="NAME_MAX"
              autocomplete="email"
              class="cm-input"
              placeholder="you@company.com"
            />
          </label>

          <label class="cm-field">
            <span class="cm-field__label">message</span>
            <textarea
              v-model="message"
              name="message"
              required
              rows="4"
              :maxlength="MESSAGE_MAX"
              class="cm-input cm-textarea"
              placeholder="A bit about the project or role…"
            />
          </label>

          <!-- Honeypot: hidden from users + assistive tech, off the tab order, and
               named/marked so password managers don't autofill it. -->
          <div class="cm-hp" aria-hidden="true">
            <label>
              Leave this field empty
              <input
                v-model="honeypot"
                type="text"
                name="hp_url"
                tabindex="-1"
                autocomplete="off"
                data-lpignore="true"
                data-1p-ignore
              />
            </label>
          </div>

          <div v-if="status === 'error'" class="cm-error" role="alert">
            Something went wrong sending that. Please try again in a moment.
          </div>

          <div class="cm-actions">
            <span class="cm-actions__note">résumé available on request</span>
            <button
              type="submit"
              class="btn btn-primary cm-submit"
              :disabled="status === 'sending'"
            >
              {{ status === 'sending' ? 'Sending…' : 'Send message' }}
              <ArrowRight v-if="status !== 'sending'" :size="16" />
            </button>
          </div>
        </form>
      </div>
    </div>
  </Transition>
</template>

<style scoped>
.cm-overlay {
  position: fixed;
  inset: 0;
  z-index: var(--z-modal);
  display: grid;
  place-items: center;
  padding: 24px;
  background: rgba(15, 23, 42, 0.55);
  backdrop-filter: blur(6px);
  -webkit-backdrop-filter: blur(6px);
}

.cm-card {
  width: 100%;
  max-width: 520px;
  background: var(--bg-surface);
  padding: 0;
  overflow: hidden;
  box-shadow: 0 32px 80px rgba(15, 23, 42, 0.28);
}

/* Header */
.cm-head {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16px;
  padding: 26px 28px 18px;
  border-bottom: 1px solid var(--border-1);
}
.cm-head__eyebrow {
  font-family: var(--font-mono);
  font-size: 12px;
  color: var(--brand);
  letter-spacing: 0.08em;
  text-transform: lowercase;
}
.cm-head__title {
  margin-top: 8px;
  font-size: 22px;
}
.cm-close {
  flex-shrink: 0;
  width: 36px;
  height: 36px;
  border-radius: var(--radius-pill);
  border: 1px solid var(--border-2);
  background: transparent;
  color: var(--fg-2);
  display: grid;
  place-items: center;
  cursor: pointer;
  transition: border-color var(--dur-fast) var(--ease-out), color var(--dur-fast) var(--ease-out);
}
.cm-close:hover {
  border-color: var(--border-strong);
  color: var(--fg-1);
}

/* Sent state */
.cm-sent {
  padding: 40px 28px 44px;
  text-align: center;
}
.cm-sent__icon {
  width: 52px;
  height: 52px;
  border-radius: var(--radius-pill);
  margin: 0 auto 18px;
  display: grid;
  place-items: center;
  background: var(--bg-tint);
  border: 1px solid var(--border-brand);
  color: var(--brand);
}
.cm-sent__title {
  font-family: var(--font-display);
  font-size: 19px;
  font-weight: 700;
  color: var(--fg-1);
  margin: 0;
}
.cm-sent__body {
  margin: 10px auto 0;
  font-size: 14.5px;
  line-height: 1.6;
  color: var(--fg-2);
  max-width: 40ch;
}
.cm-sent__btn {
  margin-top: 24px;
}

/* Form */
.cm-form {
  padding: 22px 28px 28px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.cm-field {
  display: flex;
  flex-direction: column;
  gap: 7px;
}
.cm-field__label {
  font-family: var(--font-mono);
  font-size: 11.5px;
  color: var(--fg-3);
  letter-spacing: 0.05em;
  text-transform: lowercase;
}
.cm-input {
  width: 100%;
  box-sizing: border-box;
  font-family: var(--font-body);
  font-size: 14.5px;
  color: var(--fg-1);
  background: var(--bg-page);
  border: 1px solid var(--border-2);
  border-radius: var(--radius-md);
  padding: 11px 13px;
  transition: border-color var(--dur-fast) var(--ease-out), box-shadow var(--dur-fast) var(--ease-out);
  outline: none;
}
.cm-input::placeholder {
  color: var(--fg-4);
}
.cm-input:focus {
  border-color: var(--brand);
  box-shadow: 0 0 0 3px var(--border-brand);
}
.cm-textarea {
  resize: vertical;
  min-height: 96px;
}

/* Honeypot — visually + semantically hidden, but still in the DOM for bots. */
.cm-hp {
  position: absolute;
  left: -9999px;
  width: 1px;
  height: 1px;
  overflow: hidden;
}

.cm-error {
  font-size: 13.5px;
  color: var(--danger);
  font-family: var(--font-body);
}

.cm-actions {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  margin-top: 4px;
  flex-wrap: wrap;
}
.cm-actions__note {
  font-family: var(--font-mono);
  font-size: 11.5px;
  color: var(--fg-3);
}
.cm-submit:disabled {
  opacity: 0.7;
  cursor: default;
}

/* Transitions (replacing the design's cm-fade / cm-rise keyframes) */
.cm-enter-active,
.cm-leave-active {
  transition: opacity 160ms var(--ease-out);
}
.cm-enter-from,
.cm-leave-to {
  opacity: 0;
}
.cm-enter-active .cm-card {
  animation: cm-rise 220ms var(--ease-out);
}
@keyframes cm-rise {
  from {
    opacity: 0;
    transform: translateY(12px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
