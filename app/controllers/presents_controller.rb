# frozen_string_literal: true

class PresentsController < ApplicationController
  before_action :assign_event
  before_action :assign_presents
  before_action :assign_new_present

  def index; end

  def create
    present = presents.new(present_params)
    @new_present = present unless present.save
    render(json: presents_json)
  end

  def destroy
    present = event.presents.find(params[:id])
    present.destroy
    render(json: presents_json)
  end

  private

  attr_reader :event, :presents

  def assign_event
    @event = current_user.events.find(params[:event_id])
  end

  def assign_presents
    @presents = event.presents.persisted
  end

  def assign_new_present
    @new_present = presents.new
  end

  def presents_json
    { html: render_to_string('presents/index') }
  end

  def present_params
    params.require(:present).permit(:name)
  end
end
