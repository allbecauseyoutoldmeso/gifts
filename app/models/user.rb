# frozen_string_literal: true

class User < ApplicationRecord
  has_many :recipients
  validates :email, :password, presence: true
  has_secure_password
end
