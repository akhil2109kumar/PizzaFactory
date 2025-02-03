class Order < ApplicationRecord
	belongs_to :user
	belongs_to :cart_item
	enum :status, { pending: 0, confirmed: 1 }
	validates :status, presence: true
end
