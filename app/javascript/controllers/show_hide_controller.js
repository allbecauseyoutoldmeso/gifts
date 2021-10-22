import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['toggleable']

  toggle() {
    this.toggleableTargets.forEach(target => {
      if (this.isHidden(target)) {
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

  isHidden(target) {
    return target.classList.contains(this.hiddenClass())
  }

  hiddenClass() {
    return 'hidden'
  }
}
