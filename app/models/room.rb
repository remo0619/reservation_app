class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  has_one_attached :image

  validates :name, length: { maximum: 20 }, presence: true
  validates :introduction, length: { maximum: 500 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :address, presence: true

  validates :image, content_type: { in: %w[image/jpeg image/png image/gif],
                     message: "画像ファイルを選択してください"},
                     size: { less_than: 5.megabytes, message: "5MBを超える画像はアップロードできません"}

end
