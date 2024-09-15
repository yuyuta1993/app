Rails.application.routes.draw do
  root 'tops#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'mypage', to: 'users#show'

  get 'account', to: 'users#account'

  resources :posts

  get 'search', to: 'posts#index', as: 'search'

  get 'users/edit_password', to: 'users#edit_password', as: 'edit_password'
  patch 'users/update_password', to: 'users#update_password', as: 'update_password'

  resources :favorites, only: [:create, :destroy, :index]

  resources :users, only: [:create, :show] do
    resources :posts, only: [:index] 
    get 'favorites', to: 'favorites#index' 
  end
end
