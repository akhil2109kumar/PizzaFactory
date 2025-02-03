class Topping < ApplicationRecord
	enum :category, { vegetarian: 0, non_vegetarian: 1, extra_cheese: 2 }

	has_many :pizza_toppings
	has_many :pizzas, through: :pizza_toppings
	has_many :topping_orders
	has_many :pizza_orders, through: :topping_orders

	validates :name, presence: true, uniqueness: true
	validates :price, presence: true, numericality: { greater_than: 0 }
	validates :category,presence: true

	after_create :add_to_inventory

	def add_to_inventory
		Inventory.find_or_create_by(item_type: self.class.to_s, item_id: self.id, quantity: 10)
	end
end
