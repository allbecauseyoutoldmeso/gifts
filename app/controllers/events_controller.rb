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

  def update
    event = current_user.events.find(params[:id])
    event.update(event_params)
  end

  private

  def event_params
    params
      .require(:event)
      .permit(:recipient_id, :name, :date, :recurring, :state)
      .tap { |params| params[:state] = params[:state].to_i }
  end
end
