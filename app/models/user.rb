class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ーa-zA-Z0-9\s]+\z/, message: 'はひらがな、カタカナ、漢字、英数字のみ使用できます' }
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, presence: true, format: { with: PASSWORD_REGEX, message: 'は半角英数字混合で入力してください' }
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龠々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' } do
    validates :last_name
    validates :first_name
  end
  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナのみ使用できます' } do
    validates :last_name_kana
    validates :first_name_kana
  end
  validates :birthday, presence: true

end
