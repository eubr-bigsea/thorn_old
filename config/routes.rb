Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'users', controllers: { passwords: 'devise_token_auth/passwords' }
  get 'user' => 'user#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
