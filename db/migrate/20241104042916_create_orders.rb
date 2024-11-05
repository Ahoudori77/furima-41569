class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :purchase,      null: false, foreign_key: true
      t.string     :status,        null: false, default: "pending"
      t.integer    :total_price,   null: false
      t.string     :payment_method, null: false
      t.string     :payment_status, null: false, default: "unpaid"
      t.string     :tracking_number

      t.timestamps
    end
  end
end