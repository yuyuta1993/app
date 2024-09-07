class TopsController < ApplicationController
  before_action :set_url_options

  def index
    @posts = Post.limit(6).order(created_at: :desc)
  end

  private

  def set_url_options
    ActiveStorage::Current.url_options = { host: request.base_url }
  end
end
