Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, skip: %i[confirmations registrations]
    devise_scope :user do
      resource :registration, only: %i[create update], path: 'users', controller: 'registrations'
    end

    resources :users, only: %i[] do
      collection do
        get :me
      end
    end

    resources :tokens, only: :create
  end
  scope :administration, defaults: { format: :json } do
    resources :projects
    resources :teams
    resources :users do
      member do
        post :confirm
      end
    end
  end
end
