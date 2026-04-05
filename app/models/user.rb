class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :rooms
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :avatar

  validates :name, length: { maximum: 20 }, presence: true
  validates :email, presence: true
  validates :bio, length: { maximum: 500 }

  validates :avatar, content_type: { in: %w[image/jpeg image/png image/gif],
                     message: "画像ファイルを選択してください"},
                     size: { less_than: 5.megabytes, message: "5MBを超える画像はアップロードできません"}
  
  # 仮想的な属性を追加
  attr_accessor :remove_avatar

  # 保存の直前に、チェックが入っていたら削除を実行する
  before_save :purge_avatar, if: -> { remove_avatar == "1" }

  private

  def purge_avatar
    avatar.purge
  end
end
