# frozen_string_literal: true

FactoryBot.define do
  factory :event_search do
    transient do
      user { create(:user) }
    end

    initialize_with { new(user) }
  end
end
