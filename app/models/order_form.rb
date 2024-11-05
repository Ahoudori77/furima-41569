class OrderForm
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :address_line, :building, 
                :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token, presence: { message: 'を入力してください' }
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンを含む7桁で入力してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :city
    validates :address_line
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の数字で入力してください' }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code, prefecture_id: prefecture_id, city: city,
      address_line: address_line, building: building, phone_number: phone_number,
      purchase_id: purchase.id
    )
  end
end