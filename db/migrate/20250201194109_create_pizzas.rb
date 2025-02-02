class CreatePizzas < ActiveRecord::Migration[8.0]
  def change
    create_table :pizzas do |t|
      t.string :name, null: false
      t.integer :category
      t.timestamps
    end
  end
end
  