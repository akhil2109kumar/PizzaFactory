class Side < ApplicationRecord
	has_many :side_orders

	validates :name, presence: true, uniqueness: true
	validates :price, presence: true, numericality: { greater_than: 0 }
	after_create :add_to_inventory
	
	def add_to_inventory
		Inventory.find_or_create_by(item_type: self.class.to_s, item_id: self.id, quantity: 10)
	end
end
