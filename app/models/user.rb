class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ーa-zA-Z0-9\s]+\z/, message: 'はひらがな、カタカナ、漢字、英数字のみ使用できます' }
  with_options presence: true, format: { with: /\A[一-龥々]+\z/, message: 'は全角文字のみ使用できます' } do
    validates :last_name
    validates :first_name
  end
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナのみ使用できます' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナのみ使用できます' }

  validates :birthday, presence: true

end
