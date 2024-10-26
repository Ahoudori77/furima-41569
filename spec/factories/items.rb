FactoryBot.define do
  factory :item do
    association :user
    category_id { 2 }
    name { "MyString" }
    description { "MyText" }
    condition_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    delivery_time_id { 2 }
    price { 300 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
