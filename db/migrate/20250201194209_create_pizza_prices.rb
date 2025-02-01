class CreatePizzaPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :pizza_prices do |t|
      t.references "pizza", foreign_key: true
      t.integer "size", null: false 
      t.decimal "price", precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
