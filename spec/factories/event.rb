# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::Lorem.word }
    date { Faker::Time.between(from: 1.week.from_now, to: 3.months.from_now) }
    recipient factory: :recipient
  end
end
