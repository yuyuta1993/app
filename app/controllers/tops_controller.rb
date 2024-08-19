class TopsController < ApplicationController
  def index
    @posts = Post.limit(6).order(created_at: :desc)
  end
end
