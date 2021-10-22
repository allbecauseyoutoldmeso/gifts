# frozen_string_literal: true

class RecurringEventFactory
  def create_events!
    events_to_recreate.each do |event|
      new_date = event.date + 1.year

      unless Event.exists?(recipient: event.recipient, date: new_date)
        new_event = event.dup
        new_event.update!(date: new_date)
      end
    end
  end

  private

  def events_to_recreate
    Event.where(
      recurring: true,
      date: start_date..end_date
    )
  end

  def start_date
    1.year.ago
  end

  def end_date
    (1.year - Event::UPCOMING_MONTHS.months).ago
  end
end
