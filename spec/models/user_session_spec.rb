# frozen_string_literal: true

require 'rails_helper'

describe UserSession do
  describe '#valid?' do
    it 'is true for factory' do
      user_session = build(:user_session)
      expect(user_session.valid?).to eq(true)
    end

    it 'is false if email is not present' do
      user_session = build(:user_session, email: nil)
      expect(user_session.valid?).to eq(false)

      expect(
        user_session.errors.messages[:email]
      ).to contain_exactly(
        t('errors.messages.blank')
      )
    end

    it 'is false if password is not present' do
      user_session = build(:user_session, password: nil)
      expect(user_session.valid?).to eq(false)

      expect(
        user_session.errors.messages[:password]
      ).to include(
        t('errors.messages.blank')
      )
    end

    it 'is false if email incorrect' do
      user_session = build(:user_session, email: 'unregistered@example.com')

      expect(user_session.valid?).to eq(false)

      expect(
        user_session.errors.messages[:base]
      ).to include(
        t(
          'activemodel.errors.models.user_session.attributes.base.invalid_credentials'
        )
      )
    end

    it 'is false if password incorrect' do
      user_session = build(:user_session, password: 'wrongpassword')

      expect(user_session.valid?).to eq(false)

      expect(
        user_session.errors.messages[:base]
      ).to include(
        t(
          'activemodel.errors.models.user_session.attributes.base.invalid_credentials'
        )
      )
    end
  end

  describe '#user' do
    it 'returns user matching email and password' do
      user_attributes = {
        email: 'jane.smith@example.com',
        password: 'password'
      }

      user = create(:user, user_attributes)
      user_session = build(:user_session, user_attributes)

      expect(user_session.user).to eq(user)
    end
  end
end
