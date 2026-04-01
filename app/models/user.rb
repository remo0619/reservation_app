class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :avatar

  validates :avatar, content_type: { in: ["image/jpeg", "image/png", "image/gif"],
                     messages: "画像ファイルを選択してください"}
end
