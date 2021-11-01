# frozen_string_literal: true

require 'rails_helper'

describe Event do
  describe '#valid?' do
    it 'is true for factory' do
      event = build(:event)
      expect(event.valid?).to eq(true)
    end

    it 'is false if date is not present' do
      event = build(:event, date: nil)
      expect(event.valid?).to eq(false)

      expect(
        event.errors.messages[:date]
      ).to contain_exactly(
        t('errors.messages.blank')
      )
    end
  end

  describe '.upcoming' do
    it 'returns events in next 3 months ordered by date' do
      _event_1 = create(:event, date: 1.day.ago)
      event_2 = create(:event, date: Date.current)
      event_3 = create(:event, date: 2.months.from_now)
      event_4 = create(:event, date: 1.month.from_now)
      event_5 = create(:event, date: 3.months.from_now)
      _event_6 = create(:event, date: 3.months.from_now + 1.day)

      expect(described_class.upcoming).to eq(
        [event_2, event_4, event_3, event_5]
      )
    end
  end

  describe '#who' do
    it 'returns recipient name' do
      event = create(:event)
      expect(event.who).to eq(event.recipient.name)
    end
  end

  describe '#what' do
    it 'returns event_type name' do
      event = create(:event)
      expect(event.what).to eq(event.event_type.name)
    end
  end

  describe '#when' do
    it 'returns date' do
      event = create(:event)
      expect(event.when).to eq(event.date)
    end
  end
end
