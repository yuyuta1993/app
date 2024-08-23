Rails.application.routes.draw do

  root 'tops#index'

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'
  get 'mypage', to: 'users#show'


  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users do
    resources :posts, only: [:index]  # ユーザーが投稿した全ての投稿
    get 'favorites', to: 'favorites#index'  # ユーザーのお気に入り投稿
  end
end
