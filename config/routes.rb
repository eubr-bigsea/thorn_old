Rails.application.routes.draw do
  #Devise
  devise_for :users, controllers: {sessions: 'sessions'}
  resources :users

  #API Routes
  namespace :api do
    resources :users
    resources :tokens, only: [:create]
    resources :cards
  end
end
