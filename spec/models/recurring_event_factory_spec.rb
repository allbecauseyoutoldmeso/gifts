# frozen_string_literal: true

require 'rails_helper'

describe RecurringEventFactory do
  describe '#create_events!' do
    it 'creates new version of recurring event within range' do
      event = create(:event, date: (1.year - 1.day).ago, recurring: true)

      expect do
        described_class.new.create_events!
      end.to change(Event, :count).by(1)

      expect(Event.last).to have_attributes(
        recurring: true,
        recipient: event.recipient,
        date: Date.tomorrow,
        name: event.name,
        presents: []
      )
    end

    it 'does not create new version of non-recurring event' do
      create(:event, date: (1.year - 1.day).ago, recurring: false)

      expect do
        described_class.new.create_events!
      end.not_to change(Event, :count)
    end

    it 'does not create new version of event if one already exists' do
      event = create(:event, date: (1.year - 1.day).ago, recurring: true)
      create(:event, date: Date.tomorrow, recipient: event.recipient)

      expect do
        described_class.new.create_events!
      end.not_to change(Event, :count)
    end

    it 'does not create version of event on far side of range' do
      create(:event, date: (1.year + 1.day).ago, recurring: true)

      expect do
        described_class.new.create_events!
      end.not_to change(Event, :count)
    end

    it 'does not create version of event on near side of range' do
      create(
        :event,
        date: (1.year - Event::UPCOMING_MONTHS.months - 1.day).ago,
        recurring: true
      )

      expect do
        described_class.new.create_events!
      end.not_to change(Event, :count)
    end
  end
end
