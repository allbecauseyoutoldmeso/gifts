# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user

  def authenticate_user
    redirect_to(new_user_session_path) if current_user.blank?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end
end
