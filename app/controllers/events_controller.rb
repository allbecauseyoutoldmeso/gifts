# frozen_string_literal: true

class EventsController < ApplicationController
  include Eventable

  def upcoming
    @events = current_user.events.upcoming
  end

  def index; end

  def create
    event = events.new(event_params)
    @new_event = event unless event.save
    @show_new_event_form = true
    render(json: { html: render_to_string('events/index') })
  end

  private

  def event_params
    params.require(:event).permit(:recipient_id, :name, :date, :recurring)
  end
end
