# frozen_string_literal: true

FactoryBot.define do
  factory :event_presenter do
    transient do
      user { create(:user) }
      recipient { create(:recipient, user: user) }
      event_type { create(:event_type, user: user) }
    end

    initialize_with { new(user) }

    date { Faker::Time.between(from: 1.week.from_now, to: 3.months.from_now) }
    new_recipient { false }
    recipient_id { recipient.id }
    new_event_type { false }
    event_type_id { event_type.id }
  end
end
