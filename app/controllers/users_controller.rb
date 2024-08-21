class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the CoffeeBlog!"
      redirect_to root_path  # 登録後にトップページへリダイレクト
    else
      render 'new'  # 入力内容にエラーがあれば再度フォームを表示
    end
  end


  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
end
