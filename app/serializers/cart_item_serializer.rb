class CartItemSerializer
  include JSONAPI::Serializer
  attributes :id, :total_price

  attributes :pizzas do |object|
    object.pizza_orders.includes(pizza: :pizza_prices).map do |pizza_order|
      pizza = pizza_order.pizza
      next unless pizza 

      {
        pizza_order_id: pizza_order.id,
        id: pizza.id,
        pizza_name: pizza.name,
        pizza_category: pizza.category,
        pizza_sizes: pizza.pizza_prices.select { |price| price.size == pizza_order.size }
                                       .map { |price| { id: price.id, size: price.size, price: price.price } },
        quantity: pizza_order.quantity
      }
    end.compact.uniq
  end

  attributes :toppings do |object|
    object.pizza_orders.includes(topping_orders: :topping).flat_map do |pizza_order|
      pizza_order.topping_orders.map do |topping_order|
        topping = topping_order.topping
        next unless topping 

        { 
          pizza_order_id: pizza_order.id,
          id: topping.id,
          name: topping.name,
          category: topping.category,
          price: topping.price
        }
      end
    end.compact.uniq
  end

  attributes :sides do |object|
    object.side_orders.includes(:side).map do |side_order|
      side = side_order.side
      next unless side 

      {
        id: side.id,
        name: side.name,
        price: side.price,
        quantity: side_order.quantity
      }
    end.compact.uniq
  end
end
