# frozen_string_literal: true

FactoryBot.define do
  factory :event_presenter do
    transient do
      user { create(:user) }
      recipient { create(:recipient, user: user) }
    end

    initialize_with { new(user) }

    name { 'Birthday' }
    date { Faker::Time.between(from: 1.week.from_now, to: 3.months.from_now) }
    new_recipient { false }
    recipient_id { recipient.id }
  end
end
