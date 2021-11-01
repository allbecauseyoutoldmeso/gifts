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

  def state_icon_class(state)
    {
      purchased: 'fas fa-shopping-bag',
      wrapped: 'fas fa-gift',
      gifted: 'far fa-check-circle',
      pending: 'far fa-question-circle'
    }.with_indifferent_access[state]
  end

  def boolean_icon_class(boolean)
    {
      true => 'fas fa-check',
      false => 'fas fa-times'
    }.with_indifferent_access[boolean.to_s]
  end
end
