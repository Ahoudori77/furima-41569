class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, format: { with: /\A[ぁ-んァ-ン一-龠 々ーa-zA-Z0-9]+\z/, message: "はひらがな、カタカナ、漢字、英数字のみ使用できます" }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "は有効なメールアドレスを入力してください" }
  with_options presence: true, format: { with: /\A[一-龠ぁ-んァ-ン]+\z/, message: "は全角文字のみ使用できます" } do
    validates :last_name
    validates :first_name
  end
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/, message: "は全角カタカナのみ使用できます" }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/, message: "は全角カタカナのみ使用できます" }

  PASSWORD_REGEX = /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,}\z/.freeze
  validates :password, presence: true, format: { with: PASSWORD_REGEX, message: "は6文字以上で、英字と数字を両方含める必要があります" }
  
  validates :birthday, presence: true

  has_many :items
  has_many :purchases
end
