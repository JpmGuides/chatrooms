Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  get 'login', to: 'user#show_login'
  post 'login', to: 'user#login'
  get 'logout', to: 'user#logout'

  resources :conversation, only: [:show, :create] do
    resources :message, only: [:create]
  end

  match '*path', to: redirect('/'), via: :all
end
