# frozen_string_literal: true

class PresentsController < ApplicationController
  before_action :assign_event
  before_action :assign_presents

  def index
    @new_present = presents.new
  end

  def create
    present = presents.new(present_params)
    @new_present = present.save ? presents.new : present
    render(json: { html: render_to_string('presents/index') })
  end

  private

  attr_reader :event, :presents

  def assign_event
    @event = current_user.events.find(params[:event_id])
  end

  def assign_presents
    @presents = event.presents.persisted
  end

  def present_params
    params.require(:present).permit(:name)
  end
end
