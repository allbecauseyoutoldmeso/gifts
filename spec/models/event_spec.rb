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

  describe '.persisted' do
    it 'returns only persisted events' do
      event_1 = create(:event)
      _event_2 = build(:event)

      expect(described_class.persisted).to contain_exactly(event_1)
    end
  end
end
