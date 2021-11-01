# frozen_string_literal: true

class EventsController < ApplicationController
  include Eventable

  before_action :assign_event, only: %i[show update]

  def upcoming
    @events = current_user.events.upcoming
  end

  def index; end

  def show
    @new_present = event.presents.new
  end

  def update
    event.update(event_params)
  end

  private

  attr_reader :event

  def event_params
    params.require(:event).permit(:state)
  end

  def assign_event
    @event = current_user.events.find(params[:id])
  end
end
