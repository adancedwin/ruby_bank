# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#show'

  resources :users, only: :show

  get '/transactions', to: 'transactions#index'
  resource :transactions, only: %i[new create]

  get '/session', to: 'session#new'
  post '/session', to: 'session#create'
  delete '/session', to: 'session#destroy'

  get '/new_transfer', to: 'transactions#new'
  post '/transfer', to: 'transactions#transfer'
end
