class OrdersController < ApplicationController

  def create_pizza_order
    service = OrderService.new(current_user)
    begin
      pizza_order = service.add_pizza_order(params[:pizza_id], params[:crust_id], params[:size], params[:quantity].to_i)
      render json: { status: 'success', pizza_order: pizza_order }, status: :created
    rescue => e
      render json: { status: 'error', message: e.message }, status: :unprocessable_entity
    end
  end

  def create_topping_order
    service = OrderService.new(current_user)
    begin
      topping_order = service.add_topping_order(params[:pizza_order_id], params[:topping_id])
      render json: { status: 'success', topping_order: topping_order }, status: :created
    rescue => e
      render json: { status: 'error', message: e.message }, status: :unprocessable_entity
    end
  end

  def create_side_order
    service = OrderService.new(current_user)
    begin
      side_order = service.add_side_order(params[:side_id], params[:quantity].to_i)
      render json: { status: 'success', side_order: side_order }, status: :created
    rescue => e
      render json: { status: 'error', message: e.message }, status: :unprocessable_entity
    end
  end

  def checkout
    service = OrderService.new(current_user)
    begin
      order = service.checkout
      render json: { status: 'success', order: order }, status: :created
    rescue => e
      render json: { status: 'error', message: e.message }, status: :unprocessable_entity
    end
  end

  def view_cart
    cart_item = current_user.cart_items.find_by(converted_to_order: false) 
    if cart_item
      render json: { status: 'success', cart: CartItemSerializer.new(cart_item) }, status: :ok
    else
      render json: { status: 'error', message: 'Cart is empty' }, status: :not_found
    end
  end

  def delete_cart
    service = OrderService.new(current_user)
    begin
      service.delete_cart
      render json: { status: 'success', message: 'Cart has been emptied and inventory restored' }, status: :ok
    rescue => e
      render json: { status: 'error', message: e.message }, status: :unprocessable_entity
    end
  end

  def list_orders
    orders = Order.where(user_id: current_user.id)
    if orders.any?
      render json: { status: 'success', orders: OrderSerializer.new(orders) }, status: :ok
    else
      render json: { status: 'error', message: 'No orders found' }, status: :not_found
    end
  end

  def menu
    menu = []
    menu << {Pizzas: PizzaSerializer.new(Pizza.all), Crusts: Crust.all, Toppings: Topping.all, Sides: Side.all}
    if menu.any?
      render json: { status: 'success', menu: menu  }, status: :ok
    else
      render json: { status: 'error', message: 'No content' }, status: :not_found
    end
  end
end
