Rails.application.routes.draw do
  get 'home' => 'home#index'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' }
end
