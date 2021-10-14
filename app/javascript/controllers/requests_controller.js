import { Controller } from 'stimulus'
import Rails from '@rails/ujs'

export default class extends Controller {
  submitForm(event) {
    event.preventDefault()
    const form = event.currentTarget

    Rails.ajax({
      type: form.method,
      url: form.action,
      data: new FormData(form),
      success: (data) => {
        this.element.outerHTML = data.html
      }
    })
  }
}
