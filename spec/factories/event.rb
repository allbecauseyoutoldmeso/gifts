# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'Christmas' }
    date { 2.months.from_now }
    recipient factory: :recipient
  end
end
