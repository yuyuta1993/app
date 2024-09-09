class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully signed up!"
    else
      render 'new'
    end
  end

  def show
    @user = current_user  # 現在のログインユーザー
    @posts = @user.posts.limit(6).order(created_at: :desc)  # 自身の投稿
    @favorites = @user.favorite_posts.limit(6).order(created_at: :desc)  # お気に入り投稿
  end

  def account
    @user = current_user  # 現在のログインユーザーを取得
  end

    # パスワード編集ページの表示
    def edit_password
      @user = current_user
    end
  
    # パスワードの更新処理
    def update_password
      @user = current_user
      if @user.update(user_params)
        redirect_to account_path, notice: 'パスワードが更新されました。'
      else
        render 'edit_password'
      end
    end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end

  def require_login
    unless current_user
      flash[:error] = "ログインが必要です"
      redirect_to login_path
    end
  end
end
