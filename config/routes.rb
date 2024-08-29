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

  # myaccount_page routes
  get 'account', to: 'users#account'

  # Posts routes
  resources :posts, only: [:index, :new, :create, :show]

  get 'search', to: 'posts#index', as: 'search'

  get 'users/edit_password', to: 'users#edit_password', as: 'edit_password'
  patch 'users/update_password', to: 'users#update_password'

  # Nested resources for users
  resources :users, only: [:create, :show] do
    resources :posts, only: [:index] 
    get 'favorites', to: 'favorites#index' 
  end
end

