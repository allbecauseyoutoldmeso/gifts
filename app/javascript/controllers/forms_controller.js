import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['newRecipient', 'recipientId', 'recipientName']

  connect() {
    this.toggleRecipientFields()
  }

  toggleRecipientFields() {
    if (this.newRecipientTarget.checked) {
      this.hide(this.recipientIdTarget)
      this.show(this.recipientNameTarget)
    } else {
      this.hide(this.recipientNameTarget)
      this.show(this.recipientIdTarget)
    }
  }

  hide(target) {
    target.classList.add(this.hiddenClass())
  }

  show(target) {
    target.classList.remove(this.hiddenClass())
  }

  hiddenClass() {
    return 'hidden'
  }
}
