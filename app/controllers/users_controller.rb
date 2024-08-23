class UsersController < ApplicationController
  before_action :require_login

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
    @favorites = @user.favorited_posts.limit(6).order(created_at: :desc)  # お気に入り投稿
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
end