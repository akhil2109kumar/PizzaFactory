# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_03_103849) do
  create_table "cart_items", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.boolean "converted_to_order", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cart_items_on_user_id"
  end

  create_table "crusts", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.string "item_type"
    t.integer "item_id"
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "cart_item_id"
    t.integer "status", default: 0, null: false
    t.decimal "total_price", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_orders_on_cart_item_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pizza_orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "cart_item_id"
    t.integer "pizza_id"
    t.integer "crust_id"
    t.integer "size", null: false
    t.integer "quantity", default: 1, null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_pizza_orders_on_cart_item_id"
    t.index ["crust_id"], name: "index_pizza_orders_on_crust_id"
    t.index ["pizza_id"], name: "index_pizza_orders_on_pizza_id"
    t.index ["user_id"], name: "index_pizza_orders_on_user_id"
  end

  create_table "pizza_prices", force: :cascade do |t|
    t.integer "pizza_id"
    t.integer "size", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pizza_id"], name: "index_pizza_prices_on_pizza_id"
  end

  create_table "pizzas", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "side_orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "cart_item_id"
    t.integer "side_id"
    t.integer "quantity", default: 1, null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_side_orders_on_cart_item_id"
    t.index ["side_id"], name: "index_side_orders_on_side_id"
    t.index ["user_id"], name: "index_side_orders_on_user_id"
  end

  create_table "sides", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topping_orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "cart_item_id"
    t.integer "pizza_order_id"
    t.integer "topping_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_topping_orders_on_cart_item_id"
    t.index ["pizza_order_id"], name: "index_topping_orders_on_pizza_order_id"
    t.index ["topping_id"], name: "index_topping_orders_on_topping_id"
    t.index ["user_id"], name: "index_topping_orders_on_user_id"
  end

  create_table "toppings", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.string "jti", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cart_items", "users"
  add_foreign_key "orders", "cart_items"
  add_foreign_key "orders", "users"
  add_foreign_key "pizza_orders", "cart_items"
  add_foreign_key "pizza_orders", "crusts"
  add_foreign_key "pizza_orders", "pizzas"
  add_foreign_key "pizza_orders", "users"
  add_foreign_key "pizza_prices", "pizzas"
  add_foreign_key "side_orders", "cart_items"
  add_foreign_key "side_orders", "sides"
  add_foreign_key "side_orders", "users"
  add_foreign_key "topping_orders", "cart_items"
  add_foreign_key "topping_orders", "pizza_orders"
  add_foreign_key "topping_orders", "toppings"
  add_foreign_key "topping_orders", "users"
end
