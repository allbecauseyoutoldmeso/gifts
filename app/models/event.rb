# frozen_string_literal: true

class Event < ApplicationRecord
  UPCOMING_MONTHS = 3

  belongs_to :recipient
  belongs_to :event_type
  has_many :presents, dependent: :destroy

  validates :date, presence: true

  scope :upcoming, lambda {
    where(date: Date.current..UPCOMING_MONTHS.months.from_now).order(:date)
  }

  enum state: { pending: 0, purchased: 1, wrapped: 2, gifted: 3 }

  alias_attribute :when, :date

  def who
    recipient.name
  end

  def what
    event_type.name
  end
end
