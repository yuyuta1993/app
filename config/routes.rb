Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  root 'tops#index'

  # Sessions routes (Login/Logout)
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # User registration routes
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'  # ここで統一

  # MyPage route
  get 'mypage', to: 'users#show'

  # Posts routes
  resources :posts, only: [:new, :create]

  # Nested resources for users
  resources :users, only: [:create, :show] do
    resources :posts, only: [:index]  # ユーザーが投稿した全ての投稿
    get 'favorites', to: 'favorites#index'  # ユーザーのお気に入り投稿
  end
end
