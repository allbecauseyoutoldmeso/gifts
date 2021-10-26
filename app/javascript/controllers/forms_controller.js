import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['newField', 'idField', 'nameField']

  connect() {
    if (this.idOptions().length <= 1) {
      this.newFieldTarget.checked = true
      this.hide(this.newFieldTarget.parentElement)
    }

    this.toggleNewFields()
  }

  toggleNewFields() {
    if (this.newFieldTarget.checked) {
      this.hide(this.idFieldTarget)
      this.show(this.nameFieldTarget)
    } else {
      this.hide(this.nameFieldTarget)
      this.show(this.idFieldTarget)
    }
  }

  idOptions() {
    return this.idFieldTarget.querySelectorAll('option')
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
