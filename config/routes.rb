# frozen_string_literal: true

Rails.application.routes.draw do
  root 'events#upcoming'

  resources :user_sessions, only: %i[new create] do
    post :delete, on: :collection
  end

  resources :events, only: %i[index update] do
    get :upcoming, on: :collection
    resources :presents, only: %i[index create destroy]
  end

  resources :event_presenters, only: %i[create]
  resources :event_searches, only: %i[create]
end
