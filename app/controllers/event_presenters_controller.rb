# frozen_string_literal: true

class EventPresentersController < ApplicationController
  include Eventable

  def create
    event_presenter = EventPresenter.new(current_user)
    event_presenter.attributes = event_presenter_params
    @new_event_presenter = event_presenter unless event_presenter.save
    @show_new_event_form = true
    render(json: { html: render_to_string('events/index') })
  end

  private

  def event_presenter_params
    params.require(:event_presenter).permit(
      :recipient_id,
      :new_recipient,
      :recipient_name,
      :name,
      :date,
      :recurring
    )
  end
end
