class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer "status", default: 0, null: false 
      t.decimal "total_price", precision: 10, scale: 2, default: 0.0
      t.timestamps
    end
  end
end
