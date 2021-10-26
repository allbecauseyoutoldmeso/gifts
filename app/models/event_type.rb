# frozen_string_literal: true

class EventType < ApplicationRecord
  has_many :events, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
end
