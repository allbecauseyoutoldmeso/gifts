# frozen_string_literal: true

module ApplicationHelper
  attr_reader :current_user

  def display_date(date)
    date.strftime("#{date.day.ordinalize} %b %y")
  end

  def state_options
    Event.states.keys.map do |key|
      [t("activerecord.attributes.event.states.#{key}"), key]
    end
  end
end
