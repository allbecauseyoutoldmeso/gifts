# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :assign_events

  def index
    @new_event = events.new
  end

  def create
    event = events.new(event_params)
    @new_event = event.save ? events.new : event
    render(json: { html: render_to_string('events/index') })
  end

  private

  attr_reader :events

  def assign_events
    @events = current_user.events.persisted
  end

  def event_params
    params.require(:event).permit(:recipient_id, :name, :date)
  end
end
