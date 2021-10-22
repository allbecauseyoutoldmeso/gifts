# frozen_string_literal: true

Rails.application.routes.draw do
  root 'events#upcoming'

  resources :user_sessions, only: %i[new create] do
    post :delete, on: :collection
  end

  resources :events, only: %i[index create] do
    get :upcoming, on: :collection
    resources :presents, only: %i[index create destroy]
  end

  resources :event_searches, only: %i[create]

  resources :recipients, only: %i[index create]
end
