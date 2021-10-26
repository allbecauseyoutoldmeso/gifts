# frozen_string_literal: true

FactoryBot.define do
  factory :event_type do
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

    name { holidays.sample }
    user factory: :user
  end
end
