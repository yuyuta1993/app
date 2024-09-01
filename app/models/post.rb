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

  # 日本語表記を提供するメソッド
  def self.roast_level_names
    {
      raw_beans: '生豆 (raw beans)',
      light_roast: 'ライトロースト (Light roast)',
      cinnamon_roast: 'シナモンロースト (Cinnamon roast)',
      medium_roast: 'ミディアムロースト (Medium roast)',
      high_roast: 'ハイロースト (High roast)',
      city_roast: 'シティロースト (City roast)',
      fullcity_roast: 'フルシティロースト (Fullcity roast)',
      french_roast: 'フレンチロースト (French roast)',
      italian_roast: 'イタリアンロースト (Italian roast)'
    }
  end

  # 焙煎度の表示名を取得するインスタンスメソッド
  def roast_level_text
    self.class.roast_level_names[roast_level.to_sym] || '不明な焙煎度'
  end
end


