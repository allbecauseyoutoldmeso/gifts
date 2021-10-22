# frozen_string_literal: true

task create_recurring_events: :environment do
  RecurringEventFactory.new.create_events!
end
