Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :create, :show], param: :username
  put 'users/profile', to: 'users#update'
  delete 'users/profile', to: 'users#destroy'
  post '/auth/login', to: 'authentication#login'
end
