class Order < ApplicationRecord
	has_many :pizza_orders
	has_many :pizzas, through: :pizza_orders
	has_many :side_orders
	has_many :sides, through: :side_orders

	validates :status, presence: true
end
