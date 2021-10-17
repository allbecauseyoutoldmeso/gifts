# frozen_string_literal: true

class Present < ApplicationRecord
  belongs_to :event

  validates :name, presence: true

  scope :persisted, -> { where.not(id: nil) }
end
