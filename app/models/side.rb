class Side < ApplicationRecord
	has_many :order_sides

	validates :name, presence: true, uniqueness: true
	validates :price, presence: true, numericality: { greater_than: 0 }
end
