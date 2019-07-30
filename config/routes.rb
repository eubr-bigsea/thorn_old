Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users
    resources :tokens, only: :create
  end
end
