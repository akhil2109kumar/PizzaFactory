class Pizza < ApplicationRecord

	has_many :pizza_orders
	has_many :orders, through: :pizza_orders
	has_many :pizza_toppings
	has_many :toppings, through: :pizza_toppings

	enum category: { vegetarian: 0, non_vegetarian: 1 }
	validates :name, presence: true, uniqueness: true
	validates :category, presence: true
end
