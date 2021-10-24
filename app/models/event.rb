# frozen_string_literal: true

class Event < ApplicationRecord
  UPCOMING_MONTHS = 3

  belongs_to :recipient
  has_many :presents, dependent: :destroy

  validates :name, :date, :recipient_id, presence: true

  scope :upcoming, lambda {
    where(date: Date.current..UPCOMING_MONTHS.months.from_now).order(:date)
  }

  enum state: { pending: 0, done: 1 }
end
