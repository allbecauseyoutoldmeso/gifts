# frozen_string_literal: true

require 'rails_helper'

describe Recipient do
  describe '#valid?' do
    it 'is true for factory' do
      recipient = build(:recipient)
      expect(recipient.valid?).to eq(true)
    end

    it 'is false if name is not present' do
      recipient = build(:recipient, name: nil)
      expect(recipient.valid?).to eq(false)

      expect(
        recipient.errors.messages[:name]
      ).to contain_exactly(
        I18n.t('errors.messages.blank')
      )
    end

    it 'is false if user is not present' do
      recipient = build(:recipient, user: nil)
      expect(recipient.valid?).to eq(false)

      expect(
        recipient.errors.messages[:user]
      ).to contain_exactly(
        I18n.t('errors.messages.required')
      )
    end
  end

  describe '.persisted' do
    it 'returns only persisted recipients' do
      recipient_1 = create(:recipient)
      _recipient_2 = build(:recipient)

      expect(described_class.persisted).to contain_exactly(recipient_1)
    end
  end
end
