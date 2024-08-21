Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'

  root 'tops#index'
end
