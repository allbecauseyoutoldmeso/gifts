# frozen_string_literal: true

require 'rails_helper'

describe Event do
  describe '#valid?' do
    it 'is true for factory' do
      event = build(:event)
      expect(event.valid?).to eq(true)
    end

    it 'is false if name is not present' do
      event = build(:event, name: nil)
      expect(event.valid?).to eq(false)

      expect(
        event.errors.messages[:name]
      ).to contain_exactly(
        I18n.t('errors.messages.blank')
      )
    end

    it 'is false if date is not present' do
      event = build(:event, date: nil)
      expect(event.valid?).to eq(false)

      expect(
        event.errors.messages[:date]
      ).to contain_exactly(
        I18n.t('errors.messages.blank')
      )
    end

    it 'is false if recipient_id is not present' do
      event = build(:event, recipient: nil)
      expect(event.valid?).to eq(false)

      expect(
        event.errors.messages[:recipient_id]
      ).to contain_exactly(
        I18n.t('errors.messages.blank')
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
end
