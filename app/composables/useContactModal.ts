/**
 * Global contact-modal state. Replaces the design's `window.openContactModal()`
 * event bus with SSG-safe shared state any component can open/close.
 */
export const useContactModal = () => {
  const isOpen = useState<boolean>('contact-modal-open', () => false)

  const open = () => {
    isOpen.value = true
  }

  const close = () => {
    isOpen.value = false
  }

  return { isOpen, open, close }
}
