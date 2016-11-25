Rails.application.routes.draw do
  resources :wastes
  resources :users do
    resources :user_wastes
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
