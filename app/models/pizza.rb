class Pizza < ApplicationRecord
	has_many :pizza_prices
	has_many :pizza_orders
	has_many :orders, through: :pizza_orders
	has_many :pizza_toppings
	has_many :toppings, through: :pizza_toppings
	enum :category, { vegetarian: 0, non_vegetarian: 1 }	
	
	validates :name, presence: true, uniqueness: true
	validates :category, presence: true
	after_create :add_to_inventory
	
	def add_to_inventory
		Inventory.find_or_create_by(item_type: self.class.to_s, item_id: self.id, quantity: 10)
	end

end
