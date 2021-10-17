# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :recipient
  has_many :presents, dependent: :destroy

  validates :name, :date, :recipient_id, presence: true

  scope :persisted, -> { where.not(id: nil) }

  scope :upcoming, lambda {
    where(date: Date.current..3.months.from_now).order(:date)
  }
end
