class AddRoleToUser < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :role, :integer
  end

  def down
    remove_column :users, :role
  end
end
