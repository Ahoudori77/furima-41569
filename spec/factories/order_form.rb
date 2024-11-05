FactoryBot.define do
  factory :order_form do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { 'Tokyo' }
    address_line { 'Shibuya 1-1-1' }
    building { 'Tokyo Tower' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end