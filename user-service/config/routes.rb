Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'users/:user_id', to: 'user#show'
  get 'all_users/:user_id', to: 'user#all_users'
end
