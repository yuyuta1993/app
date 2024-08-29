class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]


  def index
    if params[:q].present?
      search_query = params[:q]

      roast_level = Post.roast_levels.key(search_query) # Enum 検索用

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
    roast_level_param = post_params[:roast_level].to_i

    @post = current_user.posts.build(post_params.merge(roast_level: roast_level_param))
    if @post.save
      redirect_to mypage_path, notice: '投稿が成功しました。'
    else
      flash.now[:alert] = '投稿に失敗しました。'
      render :new
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    
    # 投稿が見つからない場合の処理
    if @post.nil?
      flash[:alert] = "投稿が見つかりませんでした。"
      redirect_to root_path
    end
  end

  private

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
