class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # ユーザーが同じ投稿を複数回お気に入りにできないようにする
   validates :user_id, uniqueness: { scope: :post_id }
end