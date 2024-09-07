class Post < ApplicationRecord
  belongs_to :user  # FK
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_one_attached :photo  # Active Storageを利用して写真を添付

  # 焙煎度のenum定義
  enum roast_level: {
    raw_beans: 0,
    light_roast: 1,
    cinnamon_roast: 2,
    medium_roast: 3,
    high_roast: 4,
    city_roast: 5,
    fullcity_roast: 6,
    french_roast: 7,
    italian_roast: 8
  }

  validates :store_name, presence: true
  validates :beans_name, presence: true
  validates :roast_level, inclusion: { in: roast_levels.keys }

  def self.roast_level_names
    {
      raw_beans: '生豆',
      light_roast: 'ライトロースト',
      cinnamon_roast: 'シナモンロースト',
      medium_roast: 'ミディアムロースト',
      high_roast: 'ハイロースト',
      city_roast: 'シティロースト',
      fullcity_roast: 'フルシティロースト',
      french_roast: 'フレンチロースト',
      italian_roast: 'イタリアンロースト'
    }
  end

end
