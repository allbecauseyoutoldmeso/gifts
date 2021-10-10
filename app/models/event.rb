# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :recipient

  validates :name, :date, presence: true
end
