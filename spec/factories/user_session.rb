# frozen_string_literal: true

FactoryBot.define do
  factory :user_session do
    transient do
      user { create(:user) }
    end

    email { user.email }
    password { user.password }
  end
end
