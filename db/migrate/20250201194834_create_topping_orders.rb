class CreateToppingOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :topping_orders do |t|
      t.references "pizza_order", foreign_key: true
      t.references "topping", foreign_key: true
      t.timestamps
    end
  end
end
