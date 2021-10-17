# frozen_string_literal: true

module ApplicationHelper
  attr_reader :current_user

  def display_date(date)
    date.strftime("#{date.day.ordinalize} of %B %Y")
  end
end
