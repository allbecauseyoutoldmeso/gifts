# frozen_string_literal: true

class UserSession
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, :password, presence: true
  validate :valid_login_credentials

  def user
    @user ||= User.find_by(email: email)&.authenticate(password)
  end

  private

  def valid_login_credentials
    if email.present? && password.present? && user.blank?
      errors.add(:base, :invalid_credentials)
    end
  end
end
