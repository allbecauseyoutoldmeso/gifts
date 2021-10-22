# frozen_string_literal: true

require 'rails_helper'

describe Present do
  describe '#valid?' do
    it 'is true for factory' do
      present = build(:present)
      expect(present.valid?).to eq(true)
    end

    it 'is false if name is not present' do
      present = build(:present, name: nil)
      expect(present.valid?).to eq(false)

      expect(
        present.errors.messages[:name]
      ).to contain_exactly(
        t('errors.messages.blank')
      )
    end
  end
end
