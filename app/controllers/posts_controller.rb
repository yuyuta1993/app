class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:q].present?
      search_query = params[:q].strip
      roast_level = find_roast_level_by_query(search_query)  # 検索キーワードに基づいて焙煎度を見つける

      query_conditions = [
        "store_name LIKE :query",
        "beans_name LIKE :query",
        "coffee_growing_regions LIKE :query",
        "memo LIKE :query"
      ]

      # roast_level が見つかった場合に条件に追加
      if roast_level
        query_conditions << "roast_level = :roast_level"
      end

      @posts = Post.where(
        query_conditions.join(" OR "),
        query: "%#{search_query}%",
        roast_level: roast_level
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
    @post = Post.find(params[:id])  # params[:id]で指定された投稿を取得
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

  def find_roast_level_by_query(query)
    Post.roast_level_names.each do |key, name|
      return Post.roast_levels[key] if name.include?(query) || key.to_s.include?(query.downcase)
    end
    nil
  end

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
