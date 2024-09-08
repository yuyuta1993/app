class FavoritesController < ApplicationController
  before_action :require_login

  def index
    # 現在のユーザーがお気に入りに登録した投稿を取得
    @favorite_posts = current_user.favorite_posts
  end

  def create
  post = Post.find(params[:post_id])

    # 自分自身の投稿はお気に入り登録できないようにする
    if post.user_id == current_user.id
      redirect_to post_path(post), alert: '自分の投稿はお気に入り登録できません'
    else
      current_user.favorite_posts << post
      redirect_to post_path(post), notice: 'お気に入りに登録しました'
    end
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])  # params[:id] でFavoriteを取得
    post = favorite.post  # 関連するPostを取得
    favorite.destroy
    redirect_to post_path(post), notice: 'お気に入りを解除しました'
  end
end
  