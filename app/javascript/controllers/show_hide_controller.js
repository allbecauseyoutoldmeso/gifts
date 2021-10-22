import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['toggleable']

  toggle(event) {
    this.toggleableTargets.forEach(target => {
      if (target.id == event.params.id) {
        this.show(target)
      } else {
        this.hide(target)
      }
    })
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
