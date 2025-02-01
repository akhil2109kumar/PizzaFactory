class SideOrder < ApplicationRecord
	belongs_to :order_pizza
	belongs_to :topping

	validates :topping_id, uniqueness: { scope: :order_pizza_id }
end
