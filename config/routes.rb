Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: "logout",
    registration: "signup"
  },
  controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  get '/menu', to: 'orders#menu'
  post '/pizza_orders', to: 'orders#create_pizza_order'
  post '/topping_orders', to: 'orders#create_topping_order'
  post '/side_orders', to: 'orders#create_side_order'
  post '/checkout', to: 'orders#checkout'
  delete '/delete_cart', to: 'orders#delete_cart'
  get '/cart', to: 'orders#view_cart'
  get '/orders', to: 'orders#list_orders'

  put '/add_quantity', to: 'inventories#add_quantity'
  put '/reduce_quantity', to: 'inventories#reduce_quantity'
  get '/inventory', to: 'inventories#inventory'


  resources :pizzas
  resources :toppings
  resources :crusts
  resources :sides
end
