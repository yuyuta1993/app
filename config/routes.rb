Rails.application.routes.draw do
  # ユーザー登録ページのルーティング
  get 'signup', to: 'users#new'

  # ユーザー作成のルーティング (POSTメソッドを使用)
  post 'users', to: 'users#create'


  # トップページのルート設定
  root 'tops#index'
end
