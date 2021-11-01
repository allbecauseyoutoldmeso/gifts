# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    transient do
      user { create(:user) }
      what { random_holiday }
      who { Faker::Name.first_name }
    end

    event_type { create(:event_type, name: what, user: user) }
    date { Faker::Time.between(from: 1.week.from_now, to: 3.months.from_now) }
    recipient { create(:recipient, name: who, user: user) }
  end
end
