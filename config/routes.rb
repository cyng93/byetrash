Rails.application.routes.draw do

  root 'users#index'

  resources :wastes
  resources :users do
    resources :user_wastes
  end

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'signup' => 'users#new'
  post 'uesrs' => 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
