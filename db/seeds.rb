# frozen_string_literal: true

user = FactoryBot.create(:user, email: 'user@gifts.com', password: 'password')

3.times do
  recipient = FactoryBot.create(:recipient, user: user)
  event = FactoryBot.create(:event, recipient: recipient)

  2.times do
    FactoryBot.create(:present, event: event)
  end
end
