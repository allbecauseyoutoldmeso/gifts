# frozen_string_literal: true

require Rails.root.join('spec/support/holidays.rb')

user = FactoryBot.create(:user, email: 'user@gifts.com', password: 'password')

3.times do
  event = FactoryBot.create(:event, user: user)

  2.times do
    FactoryBot.create(:present, event: event)
  end
end
