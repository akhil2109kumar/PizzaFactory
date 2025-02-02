class PizzaOrder < ApplicationRecord
	belongs_to :order
	belongs_to :pizza
	belongs_to :crust

	has_many :topping_orders
	has_many :toppings, through: :topping_orders

	enum :size, { regular: 0, medium: 1, large: 2 }

	validates :quantity, presence: true, numericality: { greater_than: 0 }
end

