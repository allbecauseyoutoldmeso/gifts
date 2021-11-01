# frozen_string_literal: true

class PresentsController < ApplicationController
  before_action :assign_event, only: %i[create destroy]
  before_action :assign_new_present, only: %i[create destroy]

  def create
    present = @event.presents.new(present_params)
    @new_present = present unless present.save
    render(json: { html: render_to_string('events/show') })
  end

  def destroy
    present = event.presents.find(params[:id])
    present.destroy
    render(json: { html: render_to_string('events/show') })
  end

  private

  attr_reader :event

  def present_params
    params.require(:present).permit(:name)
  end

  def assign_event
    @event = current_user.events.find(params[:event_id])
  end

  def assign_new_present
    @new_present = event.presents.new
  end
end
