class PizzaPrice < ApplicationRecord
	belongs_to :pizza
	enum :size, { Regular: 0, Medium: 1, Large: 2 }		
end
