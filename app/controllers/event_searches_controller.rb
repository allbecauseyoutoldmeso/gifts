# frozen_string_literal: true

class EventSearchesController < ApplicationController
  def create
    event_search = EventSearch.new(current_user)
    event_search.attributes = event_search_params
    @events = event_search.results.order(created_at: :desc)
    @new_event = current_user.events.new
    render(json: { html: render_to_string('events/index') })
  end

  private

  def event_search_params
    params
      .require(:event_search)
      .permit(:recipient_id, :name, :start_date, :end_date)
  end
end
