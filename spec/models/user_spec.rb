# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe '#valid?' do
    it 'is true for factory' do
      user = build(:user)
      expect(user.valid?).to eq(true)
    end

    it 'is false if email is not present' do
      user = build(:user, email: nil)
      expect(user.valid?).to eq(false)

      expect(
        user.errors.messages[:email]
      ).to contain_exactly(
        t('errors.messages.blank')
      )
    end

    it 'is false if password is not present' do
      user = build(:user, password: nil)
      expect(user.valid?).to eq(false)

      expect(
        user.errors.messages[:password]
      ).to include(
        t('errors.messages.blank')
      )
    end
  end
end
