class Crust < ApplicationRecord
	
	has_many :order_pizzas

  	validates :name, presence: true, uniqueness: true

end
