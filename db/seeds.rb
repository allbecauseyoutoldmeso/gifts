# frozen_string_literal: true

user = FactoryBot.create(:user, email: 'user@gifts.com', password: 'password')

3.times do
  recipient = FactoryBot.create(:recipient, user: user)
  FactoryBot.create(:event, recipient: recipient)
end
