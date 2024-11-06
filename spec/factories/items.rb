FactoryBot.define do
  factory :item do
    association :user
    name { "Sample Item" }
    description { "This is a sample item." }
    category_id { 2 }
    condition_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    delivery_time_id { 2 }
    price { 500 }

    transient do
      attach_image { true }
    end

    after(:build) do |item, evaluator|
      if evaluator.attach_image
        item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_images.png')), filename: 'test_images.png', content_type: 'image/png')
      end
    end
  end
end