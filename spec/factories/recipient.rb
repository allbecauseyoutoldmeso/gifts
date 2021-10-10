# frozen_string_literal: true

FactoryBot.define do
  factory :recipient do
    name { Faker::Name.first_name }
    user factory: :user
  end
end
