# frozen_string_literal: true

class EventSearchesController < ApplicationController
  include Eventable

  def create
    @event_search = EventSearch.new(current_user)
    @event_search.attributes = event_search_params
    @event_search.valid?
    @events = @event_search.results.order(created_at: :desc)
    @show_event_search_form = true
    render(json: { html: render_to_string('events/index') })
  end

  private

  def event_search_params
    params
      .require(:event_search)
      .permit(:recipient_id, :event_type_id, :start_date, :end_date)
  end
end
