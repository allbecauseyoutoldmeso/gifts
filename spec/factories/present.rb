# frozen_string_literal: true

FactoryBot.define do
  factory :present do
    name { Faker::Book.title }
    event factory: :event
  end
end
