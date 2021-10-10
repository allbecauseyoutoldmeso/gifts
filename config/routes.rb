# frozen_string_literal: true

Rails.application.routes.draw do
  root 'user_sessions#index'

  resources :user_sessions, only: %i[new create index] do
    post :delete, on: :collection
  end
end
