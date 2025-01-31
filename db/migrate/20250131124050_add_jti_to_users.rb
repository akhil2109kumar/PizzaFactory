class AddJtiToUsers < ActiveRecord::Migration[8.0]
  add_column :users, :jti, :string, null: false
  add_index :users, :jti, unique: true
end
