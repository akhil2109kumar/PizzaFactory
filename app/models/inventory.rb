class Inventory < ApplicationRecord
	belongs_to :item, polymorphic: true # Can be Pizza, Topping, Crust, Side

 	validates :quantity, numericality: { greater_than_or_equal_to: 0 }	
end
