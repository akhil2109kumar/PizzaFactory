class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :orders
  has_many :pizza_orders
  has_many :topping_orders
  has_many :side_orders
  has_many :cart_items

  enum :role, {vendor: 0 , user: 1}
end
