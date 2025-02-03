class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.references "user", foreign_key: true
      t.decimal "total_price", precision: 10, scale: 2, null: false
      t.boolean "converted_to_order", default: false
      t.timestamps
    end
  end
end
