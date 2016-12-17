Rails.application.routes.draw do

  root 'welcome#index'

  resources :wastes
  resources :users do
    resources :thrown_wastes
    get 'thrown_wastes/new/eat' => 'thrown_wastes#eat'
    get 'thrown_wastes/new/drink' => 'thrown_wastes#drink'
    get 'thrown_wastes/new/wrapping' => 'thrown_wastes#wrapping'
    get 'thrown_wastes/new/paper' => 'thrown_wastes#paper'
    get 'thrown_wastes/statistic' => 'thrown_wastes#statistic'
    get 'thrown_wastes/reduction' => 'thrown_wastes#reduction'
  end

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'signup' => 'users#new'
  post 'users' => 'users#create'

  get 'conclusion/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
