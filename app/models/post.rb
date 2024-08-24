class Post < ApplicationRecord
  belongs_to :user  # FK
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  enum roast_level: { light_roast: 0, chinamon_roast: 1, medium_roast: 2, higt_roast: 3, city_roast: 4, fullcity_roast: 5, french_roast: 6, italian_roast: 7}  # enum for roast levels

  validates :store_name, presence: true
  validates :beans_name, presence: true
  validates :roast_level, inclusion: { in: roast_levels.keys }
end
