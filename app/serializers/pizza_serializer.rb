class PizzaSerializer
  include JSONAPI::Serializer
  attributes :id,:name

  attributes :pizza_prices do |object|
    object.pizza_prices
  end
end
