# frozen_string_literal: true

class EventsController < ApplicationController
  include Eventable

  def upcoming
    @events = current_user.events.upcoming
  end

  def index; end

  def update
    event = current_user.events.find(params[:id])
    event.update(event_params)
  end

  private

  def event_params
    params
      .require(:event)
      .permit(:state)
      .tap { |params| params[:state] = params[:state].to_i }
  end
end
