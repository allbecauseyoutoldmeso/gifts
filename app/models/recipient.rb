# frozen_string_literal: true

class Recipient < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :name, presence: true

  scope :persisted, -> { where.not(id: nil) }
end
