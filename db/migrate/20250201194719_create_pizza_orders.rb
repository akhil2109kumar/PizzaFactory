class CreatePizzaOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :pizza_orders do |t|
      t.references "order", foreign_key: true
      t.references "pizza", foreign_key: true
      t.references "crust", foreign_key: true
      t.integer "size", null: false 
      t.integer "quantity", null: false, default: 1
      t.decimal "price", precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
