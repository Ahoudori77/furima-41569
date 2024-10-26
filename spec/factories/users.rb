FactoryBot.define do
  factory :user do
    nickname { "テストユーザー" }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    birthday { Date.new(1995, 12, 19) }
    last_name { '小石原' }
    first_name { '瑞樹' }
    last_name_kana { 'コイシハラ' }
    first_name_kana { 'ミズキ' }
  end
end
