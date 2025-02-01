class CreatePizzas < ActiveRecord::Migration[8.0]
  def change
    create_table :pizzas do |t|
      t.string :name, null: false
      t.integer :category, null: false
      t.timestamps
    end
  end
end
  