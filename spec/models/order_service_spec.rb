require 'rails_helper'

RSpec.describe OrderService, type: :service do
  let(:user) { User.create!(email: "test@example.com", password: "password", jti: SecureRandom.uuid) }
  let(:pizza) { Pizza.create!(name: "Margherita", category: "vegetarian") }
  let(:crust) { Crust.create!(name: "Thin Crust") }
  let(:topping) { Topping.create!(name: "Mushroom", category: "vegetarian", price: 1.5) }
  let(:side) { Side.create!(name: "Garlic Bread", price: 4.0) }
  let!(:pizza_price) { PizzaPrice.create!(pizza_id: pizza.id, size: "Medium", price: 10.0) }

  let(:order_service) { OrderService.new(user) }

  describe "#add_pizza_order" do
    it "adds a pizza order to the cart" do
      pizza_order = order_service.add_pizza_order(pizza.id, crust.id, "Medium", 2)
      
      expect(pizza_order).to be_persisted
      expect(pizza_order.user_id).to eq(user.id)
      expect(pizza_order.quantity).to eq(2)
    end

    it "raises an error if stock is insufficient" do
      Inventory.find_by(item_type: "Pizza", item_id: pizza.id).update!(quantity: 0)
      expect { order_service.add_pizza_order(pizza.id, crust.id, "Medium", 1) }.to raise_error("Not enough stock for the pizza or crust")
    end
  end

  describe "#add_topping_order" do
    it "adds a topping to an existing pizza order" do
      pizza_order = order_service.add_pizza_order(pizza.id, crust.id, "Medium", 1)
      topping_order = order_service.add_topping_order(pizza_order.id, topping.id)

      expect(topping_order).to be_persisted
      expect(topping_order.topping_id).to eq(topping.id)
    end

    it "raises an error if topping stock is insufficient" do
      Inventory.find_by(item_type: "Topping", item_id: topping.id).update!(quantity: 0)
      pizza_order = order_service.add_pizza_order(pizza.id, crust.id, "Medium", 1)
      
      expect { order_service.add_topping_order(pizza_order.id, topping.id) }.to raise_error("Not enough stock for the topping")
    end
  end

  describe "#add_side_order" do
    it "adds a side order to the cart" do
      side_order = order_service.add_side_order(side.id, 2)

      expect(side_order).to be_persisted
      expect(side_order.quantity).to eq(2)
    end

    it "raises an error if side stock is insufficient" do
      Inventory.find_by(item_type: "Side", item_id: side.id).update!(quantity: 0)
      
      expect { order_service.add_side_order(side.id, 1) }.to raise_error("Not enough stock for the side")
    end
  end

  describe "#checkout" do
    it "converts the cart into an order" do
      order_service.add_pizza_order(pizza.id, crust.id, "Medium", 1)
      order = order_service.checkout

      expect(order).to be_persisted
      expect(order.user_id).to eq(user.id)
    end
  end

  describe "#delete_cart" do
    it "restores inventory and deletes the cart" do
      pizza_order = order_service.add_pizza_order(pizza.id, crust.id, "Medium", 2)
      order_service.add_topping_order(pizza_order.id, topping.id)
      order_service.add_side_order(side.id, 1)

      expect { order_service.delete_cart }.to change { CartItem.count }.by(-1)

      expect(Inventory.find_by(item_type: "Pizza", item_id: pizza.id).quantity).to eq(10)
      expect(Inventory.find_by(item_type: "Crust", item_id: crust.id).quantity).to eq(10)
      expect(Inventory.find_by(item_type: "Topping", item_id: topping.id).quantity).to eq(10)
      expect(Inventory.find_by(item_type: "Side", item_id: side.id).quantity).to eq(10)
    end
  end
end
