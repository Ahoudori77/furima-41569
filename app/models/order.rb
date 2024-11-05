class Order < ApplicationRecord
  belongs_to :purchase
  has_one :shipping_address

  # 支払い・注文状態の定数例
  STATUS_OPTIONS = %w[pending completed canceled]
  PAYMENT_STATUS_OPTIONS = %w[unpaid paid]

  validates :status, inclusion: { in: STATUS_OPTIONS }
  validates :payment_status, inclusion: { in: PAYMENT_STATUS_OPTIONS }
end