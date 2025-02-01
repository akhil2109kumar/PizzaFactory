class Topping < ApplicationRecord
	enum category: { vegetarian: 0, non_vegetarian: 1, extra_cheese: 2 }

	has_many :pizza_toppings
	has_many :pizzas, through: :pizza_toppings
	has_many :topping_orders
	has_many :pizza_orders, through: :topping_orders

	validates :name, presence: true, uniqueness: true
	validates :price, presence: true, numericality: { greater_than: 0 }
end
