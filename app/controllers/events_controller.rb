# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = current_user.events.persisted
    @new_event = current_user.events.new
  end

  def create
    @events = current_user.events.persisted
    @event = current_user.events.new(event_params)
    @new_event = @event.save ? current_user.events.new : @event
    render(json: { html: render_to_string('events/index') })
  end

  private

  def event_params
    params.require(:event).permit(:recipient_id, :name, :date)
  end
end
