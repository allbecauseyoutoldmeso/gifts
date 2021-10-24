# frozen_string_literal: true

module Eventable
  extend ActiveSupport::Concern

  included do
    before_action :assign_events, only: %i[index create]
    before_action :assign_new_event_presenter, only: %i[index create]
    before_action :assign_show_event_form, only: %i[index create]
    before_action :assign_show_search_form, only: %i[index create]
    before_action :assign_event_search, only: %i[index create]

    attr_reader :events
  end

  private

  def assign_events
    @events = current_user.events.all.order(created_at: :desc)
  end

  def assign_new_event_presenter
    @new_event_presenter = EventPresenter.new(current_user)
  end

  def assign_show_event_form
    @show_event_form = false
  end

  def assign_show_search_form
    @show_search_form = false
  end

  def assign_event_search
    @event_search = EventSearch.new(current_user)
  end
end
