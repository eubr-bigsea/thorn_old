Rails.application.routes.draw do
  get 'users/:id' => 'user#show'
  post 'users/valid_token' => 'user#validate_token'
  mount_devise_token_auth_for 'User', at: 'users', controllers: { passwords: 'devise_token_auth/passwords' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
