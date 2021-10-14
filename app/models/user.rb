# frozen_string_literal: true

class User < ApplicationRecord
  has_many :recipients, dependent: :destroy
  has_many :events, through: :recipients

  validates :email, :password, presence: true

  has_secure_password
end
