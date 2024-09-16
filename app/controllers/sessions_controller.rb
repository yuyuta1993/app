class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])  # Rails標準のauthenticateメソッド
      session[:user_id] = user.id  # セッションにユーザーIDを保存
      redirect_to mypage_path, notice: "ログインに成功しました。"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています。"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil  # セッションをクリアしてログアウト
    redirect_to root_path, status: :see_other
  end
end

