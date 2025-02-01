class Pizza < ApplicationRecord
	enum category: { vegetarian: 0, non_vegetarian: 1 }

	has_many :pizza_orders
	has_many :orders, through: :pizza_orders
	has_many :pizza_toppings
	has_many :toppings, through: :pizza_toppings

	validates :name, presence: true, uniqueness: true
	validates :category, presence: true
end
