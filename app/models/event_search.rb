# frozen_string_literal: true

class EventSearch
  include ActiveModel::Model

  attr_accessor :name, :start_date, :end_date, :recipient_id

  def initialize(user)
    @user = user
  end

  def results
    events = user.events
    events = by_name(events) if name.present?
    events = by_start_date(events) if start_date.present?
    events = by_end_date(events) if end_date.present?
    events = by_recipient_id(events) if recipient_id.present?
    events
  end

  private

  attr_reader :user

  def by_name(events)
    events.where('lower(events.name) = ?', name.downcase)
  end

  def by_start_date(events)
    events.where(date: start_date..)
  end

  def by_end_date(events)
    events.where(date: ..end_date)
  end

  def by_recipient_id(events)
    events.where(recipient_id: recipient_id)
  end
end
