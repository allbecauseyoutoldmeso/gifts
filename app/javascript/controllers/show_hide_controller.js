import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['toggleable', 'selectable']

  toggle(event) {
    this.toggleHidden(event.params.id)
    this.toggleSelected(event.target)
  }

  toggleHidden(targetId) {
    this.toggleableTargets.forEach(target => {
      if (target.id == targetId && this.isHidden(target)) {
        this.show(target)
      } else {
        this.hide(target)
      }
    })
  }

  toggleSelected(eventTarget) {
    this.selectableTargets.forEach(target => {
      if (target == eventTarget && !this.isSelected(target)) {
        this.select(target)
      } else {
        this.deselect(target)
      }
    })
  }

  select(target) {
    target.classList.add(this.selectedClass())
  }

  deselect(target) {
    target.classList.remove(this.selectedClass())
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

  isSelected(target) {
    return target.classList.contains(this.selectedClass())
  }

  hiddenClass() {
    return 'hidden'
  }

  selectedClass() {
    return 'selected'
  }
}
