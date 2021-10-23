# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    holidays = [
      'April Fools',
      'Buy Nothing Day',
      'Bloomsday',
      'Festivus',
      'Friendship Day',
      'Galactic Tick Day',
      'Giving Tuesday',
      'International Talk Like a Pirate Day',
      'Marathon Monday',
      'Mischief Night',
      'Mole Day',
      'Monkey Day',
      'National Gorilla Suit Day',
      'National Hugging Day',
      'No Pants Day',
      'Opposite Day',
      'Pi Day',
      'Record Store Day',
      'Singles Awareness Day ',
      'Star Wars Day',
      'Super Bowl Sunday',
      'Sweetest Day',
      'Tax Freedom Day',
      'Towel Day',
      'World Peace Day'
    ]

    transient do
      user { create(:user) }
    end

    name { holidays.sample }
    date { Faker::Time.between(from: 1.week.from_now, to: 3.months.from_now) }
    recipient { create(:recipient, user: user) }
  end
end
