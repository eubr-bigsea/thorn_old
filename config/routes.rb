Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, skip: %i[confirmations registrations]
    devise_scope :user do
      resource :registration, only: %i[create update], path: 'users', controller: 'registrations'
    end

    resources :users, only: %i[] do
      collection do
        get :available
        get :me
      end
    end

    resources :tokens, only: :create
  end
  scope :administration, defaults: { format: :json } do
    resources :roles, only: :index do
      post 'add_admin', to: 'roles#add_admin', as: 'add_admin', on: :collection
      post 'add_manager', to: 'roles#add_manager', as: 'add_manager', on: :collection
      post 'add_monitor', to: 'roles#add_monitor', as: 'add_monitor', on: :collection
      post 'remove_admin', to: 'roles#remove_admin', as: 'remove_admin', on: :collection
      post 'remove_manager', to: 'roles#remove_manager', as: 'remove_manager', on: :collection
      post 'remove_monitor', to: 'roles#remove_monitor', as: 'remove_monitor', on: :collection
    end

    resources :projects do
      post 'add_manager', to: 'projects#add_manager', as: 'add_manager', on: :member
      post 'remove_manager', to: 'projects#remove_manager', as: 'remove_manager', on: :member
    end

    resources :teams do
      post 'add_monitor', to: 'teams#add_monitor', as: 'add_monitor', on: :member
      post 'remove_monitor', to: 'teams#remove_monitor', as: 'remove_monitor', on: :member
    end

    resources :users do
      member do
        post :confirm
      end
    end
  end
end
