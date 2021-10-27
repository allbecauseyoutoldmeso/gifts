# frozen_string_literal: true

class EventSearch
  include ActiveModel::Model
  include Dateable

  attr_accessor :event_type_id, :recipient_id

  date_attributes :start_date, :end_date

  validate :end_date_not_before_start_date

  def initialize(user)
    @user = user
  end

  def results
    events = user.events
    events = by_event_type_id(events) if event_type_id.present?
    events = by_start_date(events) if start_date.present?
    events = by_end_date(events) if end_date.present?
    events = by_recipient_id(events) if recipient_id.present?
    events
  end

  private

  attr_reader :user

  def by_event_type_id(events)
    events.where(event_type_id: event_type_id)
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

  def end_date_not_before_start_date
    if start_date.present? && end_date&.before?(start_date)
      errors.add(:end_date, :before_start_date)
    end
  end
end
