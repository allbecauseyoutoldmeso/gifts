# frozen_string_literal: true

module ApplicationHelper
  attr_reader :current_user

  def display_date(date)
    date.strftime("#{date.day.ordinalize} %b %y")
  end

  def display_recurring(recurring)
    recurring ? t('events.index.recurring') : t('events.index.one_off')
  end

  def presents_link_text(event)
    if event.presents.any?
      event.presents.pluck(:name).join(', ')
    else
      t('events.index.add_presents')
    end
  end
end
