class Crust < ApplicationRecord
	
	has_many :pizza_orders

  	validates :name, presence: true, uniqueness: true

  	after_create :add_to_inventory

	def add_to_inventory
		Inventory.find_or_create_by(item_type: self.class.to_s, item_id: self.id, quantity: 10)
	end

end

