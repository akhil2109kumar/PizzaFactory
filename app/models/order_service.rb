class OrderService
  def initialize(user)
    @user = user
    @cart_item = CartItem.find_or_create_by(user: user, converted_to_order: false) do |cart|
      cart.total_price = 0.0
    end
  end

  def add_pizza_order(pizza_id, crust_id, size, quantity)
    pizza = Pizza.find(pizza_id)
    crust = Crust.find(crust_id)

    if crust.nil?
      raise "Crust not found"
    end

    if !check_inventory("Pizza", pizza_id, quantity) || !check_inventory("Crust", crust_id, quantity)
      raise "Not enough stock for the pizza or crust"
    end

    # Create pizza order
    pizza_order = PizzaOrder.create!(
      user_id: @user.id,
      cart_item_id: @cart_item.id,
      pizza_id: pizza_id,
      crust_id: crust_id,
      size: size,
      quantity: quantity
    )
    
    reduce_inventory("Pizza", pizza_id, quantity)
    reduce_inventory("Crust", crust_id, quantity)
    
    update_cart_total(pizza_order.price) 
    pizza_order
  end

  def add_topping_order(pizza_order_id, topping_id)
    topping = Topping.find(topping_id)

    pizza_order = PizzaOrder.find(pizza_order_id)
    pizza = pizza_order.pizza

    validate_topping_for_pizza(pizza, topping)

    if !check_inventory("Topping", topping_id, 1)
      raise "Not enough stock for the topping"
    end

    topping_order = ToppingOrder.create!(
      user_id: @user.id,
      cart_item_id: @cart_item.id,
      pizza_order_id: pizza_order_id,
      topping_id: topping_id
    )
    
    reduce_inventory("Topping", topping_id, 1)
    update_cart_total(topping_order.topping.price * pizza_order.quantity) if !free_toppings_check(pizza_order)
    topping_order
  end

  def add_side_order(side_id, quantity)
    if !check_inventory("Side", side_id, quantity)
      raise "Not enough stock for the side"
    end

    side_order = SideOrder.create!(
      user_id: @user.id,
      cart_item_id: @cart_item.id,
      side_id: side_id,
      quantity: quantity
    )

    reduce_inventory("Side", side_id, quantity)
    update_cart_total(side_order.price)
    side_order
  end

  def checkout
    order = Order.create!(user_id: @user.id, total_price: @cart_item.total_price, cart_item_id: @cart_item.id)
    @cart_item.update!(converted_to_order: true)
    order
  end

  def delete_cart
    restore_inventory_for_pizza_orders
    restore_inventory_for_topping_orders
    restore_inventory_for_side_orders

    topping_orders = @cart_item.pizza_orders.flat_map(&:topping_orders)
    topping_orders.each do |topping_order|
      topping_order.destroy
    end

    @cart_item.pizza_orders.each do |pizza_order|
      pizza_order.destroy
    end

    @cart_item.side_orders.each do |side_order|
      side_order.destroy
    end

    # Delete the cart item
    @cart_item.destroy
  end

  private

  def free_toppings_check(pizza_order)
    return true if pizza_order.size == "Large" && pizza_order.toppings.count <= 2 
    return false
  end

  def check_inventory(item_type, item_id, quantity)
    inventory = Inventory.find_by(item_type: item_type, item_id: item_id)
    return inventory.present? && inventory.quantity >= quantity
  end

  def reduce_inventory(item_type, item_id, quantity)
    inventory = Inventory.find_by(item_type: item_type, item_id: item_id)
    if inventory.present?
      inventory.update!(quantity: inventory.quantity - quantity)
    else
      raise "#{item_type} with ID #{item_id} not found in inventory"
    end
  end

  def restore_inventory(item_type, item_id, quantity)
    inventory = Inventory.find_by(item_type: item_type, item_id: item_id)
    if inventory.present?
      inventory.update!(quantity: inventory.quantity + quantity)
    else
      raise "#{item_type} with ID #{item_id} not found in inventory"
    end
  end

  def validate_topping_for_pizza(pizza, topping)
    if pizza.category == "non_vegetarian" && topping.category == "non_vegetarian"
      non_veg_toppings = @cart_item.pizza_orders.joins(:topping_orders).where(topping_orders: { topping_id: Topping.where(category: 'non_vegetarian').select(:id) })

      if non_veg_toppings.count >= 1 
        raise "Only one non-veg topping can be added to non-vegetarian pizza"
      end
    end

    if pizza.category == "non_vegetarian" && topping.name == "Paneer" 
      raise "Non-Vegetarian pizza cannot have paneer topping"
    end

    if pizza.category == "vegetarian" && topping.category == "non_vegetarian"
      raise "Vegetarian pizza cannot have non-vegetarian topping"
    end
  end

  def update_cart_total(amount)
    @cart_item.update!(total_price: @cart_item.total_price + amount)
  end

  def restore_inventory_for_pizza_orders
    @cart_item.pizza_orders.each do |pizza_order|
      restore_inventory("Pizza", pizza_order.pizza_id, pizza_order.quantity)
      restore_inventory("Crust", pizza_order.crust_id, pizza_order.quantity)
    end
  end

  def restore_inventory_for_topping_orders
    topping_orders = @cart_item.pizza_orders.flat_map(&:topping_orders)

    topping_orders.each do |topping_order|
     restore_inventory("Topping", topping_order.topping_id, 1)
    end
  end
  

  def restore_inventory_for_side_orders
    @cart_item.side_orders.each do |side_order|
      restore_inventory("Side", side_order.side_id, side_order.quantity)
    end
  end
end
