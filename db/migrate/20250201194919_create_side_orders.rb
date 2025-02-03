class CreateSideOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :side_orders do |t|
      t.references "user", foreign_key: true
      t.references "cart_item", foreign_key: true
      t.references "side", foreign_key: true
      t.integer "quantity", default: 1, null: false
      t.decimal "price", precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
