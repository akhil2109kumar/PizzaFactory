class SideOrder < ApplicationRecord
	belongs_to :cart_item
	belongs_to :user
	belongs_to :side

	before_save :add_price
	
	def add_price
		self.price = self.side.price * self.quantity
	end
end
