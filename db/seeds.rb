Pizza.create!([
  { name: "Deluxe Veggie", category: 0 },
  { name: "Cheese and Corn", category: 0 },
  { name: "Paneer Tikka", category: 0 },
  { name: "Non-Veg Supreme", category: 1 },
  { name: "Chicken Tikka", category: 1 },
  { name: "Pepper Barbecue Chicken", category: 1 }
])

PizzaPrice.create!([
  { pizza_id: Pizza.find_by(name: "Deluxe Veggie").id, size: "Regular", price: 150 },
  { pizza_id: Pizza.find_by(name: "Deluxe Veggie").id, size: "Medium", price: 200 },
  { pizza_id: Pizza.find_by(name: "Deluxe Veggie").id, size: "Large", price: 325 },
  { pizza_id: Pizza.find_by(name: "Cheese and Corn").id, size: "Regular", price: 175 },
  { pizza_id: Pizza.find_by(name: "Cheese and Corn").id, size: "Medium", price: 375 },
  { pizza_id: Pizza.find_by(name: "Cheese and Corn").id, size: "Large", price: 475 },
  { pizza_id: Pizza.find_by(name: "Paneer Tikka").id, size: "Regular", price: 160 },
  { pizza_id: Pizza.find_by(name: "Paneer Tikka").id, size: "Medium", price: 290 },
  { pizza_id: Pizza.find_by(name: "Paneer Tikka").id, size: "Large", price: 340 },
  { pizza_id: Pizza.find_by(name: "Non-Veg Supreme").id, size: "Regular", price: 190 },
  { pizza_id: Pizza.find_by(name: "Non-Veg Supreme").id, size: "Medium", price: 325 },
  { pizza_id: Pizza.find_by(name: "Non-Veg Supreme").id, size: "Large", price: 425 },
  { pizza_id: Pizza.find_by(name: "Chicken Tikka").id, size: "Regular", price: 210 },
  { pizza_id: Pizza.find_by(name: "Chicken Tikka").id, size: "Medium", price: 370 },
  { pizza_id: Pizza.find_by(name: "Chicken Tikka").id, size: "Large", price: 500 },
  { pizza_id: Pizza.find_by(name: "Pepper Barbecue Chicken").id, size: "Regular", price: 220 },
  { pizza_id: Pizza.find_by(name: "Pepper Barbecue Chicken").id, size: "Medium", price: 380 },
  { pizza_id: Pizza.find_by(name: "Pepper Barbecue Chicken").id, size: "Large", price: 525 }
])

Crust.create!([
  { name: "New hand tossed" },
  { name: "Wheat thin crust" },
  { name: "Cheese Burst" },
  { name: "Fresh pan pizza" }
])

Topping.create!([
  { name: "Black olive", category: 0, price: 20 },
  { name: "Capsicum", category: 0, price: 25 },
  { name: "Paneer", category: 0, price: 35 },
  { name: "Mushroom", category: 0, price: 30 },
  { name: "Fresh tomato", category: 0, price: 10 },
  { name: "Chicken tikka", category: 1, price: 35 },
  { name: "Barbeque chicken", category: 1, price: 45 },
  { name: "Grilled chicken", category: 1, price: 40 },
  { name: "Extra cheese", category: 2, price: 35 },
])

Side.create!([
  { name: "Cold drink", price: 55 },
  { name: "Mousse cake", price: 90 }
])
