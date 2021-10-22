import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['focusable']

  connect() {
    this.setFocus()
  }

  setFocus() {
    if (!!this.focusableTargets.length) {
      this.focusableTarget.focus()
    }
  }
}
