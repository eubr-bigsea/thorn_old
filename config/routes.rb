Rails.application.routes.draw do
    #Devise
    devise_for :users, path: 'api/users', controllers: {registrations: 'api/users', sessions: 'api/sessions'}

  #API Routes
  namespace :api do
    resources :users, only: [:index, :show]
    resources :tokens, only: [:create]
    resources :cards
  end
end
