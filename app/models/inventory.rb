class Inventory < ApplicationRecord
	belongs_to :item, polymorphic: true 

 	validates :quantity, numericality: { greater_than_or_equal_to: 0 }	
end
