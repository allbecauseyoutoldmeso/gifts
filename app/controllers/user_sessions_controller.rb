# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params)

    if @user_session.valid?
      session[:current_user_id] = @user_session.user.id
      redirect_to(root_path)
    else
      render(:new)
    end
  end

  def delete
    session.delete(:current_user_id)
    redirect_to(new_user_session_path)
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end
