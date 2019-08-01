Rails.application.routes.draw do
  resources :workflows
  scope :api, defaults: { format: :json } do
    devise_for :users
    resources :tokens, only: :create
  end
end
