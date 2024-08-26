Rails.application.routes.draw do
  root 'tops#index'

  # Sessions routes (Login/Logout)
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # User registration routes
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  # MyPage route
  get 'mypage', to: 'users#show'

  # Posts routes
  resources :posts, only: [:new, :create, :show] 

  # Nested resources for users
  resources :users, only: [:create, :show] do
    resources :posts, only: [:index] 
    get 'favorites', to: 'favorites#index' 
  end
end

