require 'rails_helper'

RSpec.describe OrdersController, type: :request do
  before do
    @user = User.create!(
      email: "test@example.com",
      password: "password123",
      user_name: "test",
      role: "user",
      jti: SecureRandom.uuid
    )

    payload = {
      "jti" => @user.jti,       
      "sub" => @user.id.to_s,          
      "scp" => "user",                
      "aud" => nil,                     
      "iat" => Time.now.to_i,         
      "exp" => (Time.now + 30.minutes).to_i  
    }

    @token = JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key!, 'HS256')

    @headers = { "Authorization" => "Bearer #{@token}" }

    @pizza = Pizza.create!(name: "Pepperoni", category: 1)

    @pizza_price = PizzaPrice.create!(size: 1,pizza_id: @pizza.id, price: 3.00)

    @crust = Crust.create!(name: "Thin Crust")

    @topping = Topping.create!(name: "Mushrooms", category: 1, price: 1.50)

    @side = Side.create!(name: "Garlic Bread", price: 4.99)

    @cart_item = CartItem.create!(user_id: @user.id, total_price: 0.0, converted_to_order: false)

    @pizza_order = PizzaOrder.create!(
      user_id: @user.id,
      cart_item_id: @cart_item.id,
      pizza_id: @pizza.id,
      crust_id: @crust.id,
      size: "Medium", # Assuming an integer enum for sizes
      quantity: 1,
      price: 9.99
    )
  end

  describe 'POST #create_pizza_order' do
    it 'creates a new pizza order' do
      post '/pizza_orders', params: { pizza_id: @pizza.id, crust_id: @crust.id, size: "Medium", quantity: 1 }, headers: @headers
      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body)['status']).to eq('success')
    end
  end

  describe 'POST #create_topping_order' do
    it 'adds a topping to a pizza order' do
      post '/topping_orders', params: { pizza_order_id: @pizza_order.id, topping_id: @topping.id },headers: @headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['status']).to eq('success')
    end
  end

  describe 'POST #create_side_order' do
    it 'creates a new side order' do
      post '/side_orders', params: { side_id: @side.id, quantity: 2 },headers: @headers
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['status']).to eq('success')
    end
  end

  describe 'GET #view_cart' do
    it 'returns cart details' do
      get '/cart',headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #delete_cart' do
    it 'empties the cart' do
      delete '/delete_cart',headers: @headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Cart has been emptied and inventory restored')
    end
  end

  describe 'POST #checkout' do
    it 'completes checkout process' do
      post '/checkout',headers: @headers
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET #list_orders' do
    it 'returns user orders' do
      Order.create!(user_id: @user.id, cart_item_id: @cart_item.id, total_price: 20.0)
      get '/orders',headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #menu' do
    it 'returns menu items' do
      get '/menu', headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end
end
