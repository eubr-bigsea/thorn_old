Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, skip: :registrations
    devise_scope :user do
      resource :registration, only: %i[create update], path: 'users', controller: 'registrations'
    end

    resources :tokens, only: :create
  end
  scope :administration, defaults: { format: :json } do
    resources :users do
      member do
        post :confirm
      end
    end
  end
end
