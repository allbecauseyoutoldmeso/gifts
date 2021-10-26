# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    transient do
      user { create(:user) }
    end

    event_type { create(:event_type, user: user) }
    date { Faker::Time.between(from: 1.week.from_now, to: 3.months.from_now) }
    recipient { create(:recipient, user: user) }
  end
end
