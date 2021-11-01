# frozen_string_literal: true

FactoryBot.define do
  factory :event_type do
    name { random_holiday }
    user factory: :user
  end
end
