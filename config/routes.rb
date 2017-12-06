Rails.application.routes.draw do
    #Devise
    devise_for :users, path: 'api/users', controllers: {registrations: 'api/users', sessions: 'api/sessions'}
    resource :users

  #API Routes
  namespace :api do
    resources :users
    resources :tokens, only: [:create]
    resources :cards
    resources :card_boards, only: [:show]
  end
end
