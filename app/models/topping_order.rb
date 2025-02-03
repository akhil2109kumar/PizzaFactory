class ToppingOrder < ApplicationRecord
	belongs_to :pizza_order
	belongs_to :topping

	validates :topping_id, uniqueness: { scope: :pizza_order_id }
end
