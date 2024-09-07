class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:q].present?
      search_query = params[:q]
      roast_level = Post.roast_levels.key(search_query)

      @posts = Post.where(
        "store_name LIKE :query OR beans_name LIKE :query OR coffee_growing_regions LIKE :query OR memo LIKE :query OR roast_level = :roast_level",
        query: "%#{search_query}%", roast_level: roast_level
      )
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to mypage_path, notice: '投稿が成功しました。'
    else
      flash.now[:alert] = '投稿に失敗しました。'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    if @post.nil? || current_user != @post.user
      flash[:alert] = "この操作を実行する権限がありません。"
      redirect_to(root_path)
    end
  end

  def post_params
    params.require(:post).permit(:store_name, :beans_name, :roast_level, :coffee_growing_regions, :photo, :memo)
  end

  def require_login
    unless logged_in?
      flash[:error] = "ログインが必要です"
      redirect_to login_path
    end
  end
end
