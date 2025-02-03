class PizzaOrder < ApplicationRecord
	belongs_to :pizza
	belongs_to :crust
	belongs_to :cart_item
	belongs_to :user

	has_many :topping_orders
	has_many :toppings, through: :topping_orders
	before_save :add_price 
	enum :size, { Regular: 0, Medium: 1, Large: 2 }

	validates :quantity, presence: true, numericality: { greater_than: 0 }

	def add_price
		self.price = self.pizza.pizza_prices.find_by(size: self.size).price * self.quantity
	end
end

