# frozen_string_literal: true

Rails.application.routes.draw do
  root 'events#upcoming'

  resources :user_sessions, only: %i[new create] do
    post :delete, on: :collection
  end

  resources :events, only: %i[index update show] do
    get :upcoming, on: :collection
    resources :presents, only: %i[create destroy]
  end

  resources :event_presenters, only: %i[create]
  resources :event_searches, only: %i[create]
end
