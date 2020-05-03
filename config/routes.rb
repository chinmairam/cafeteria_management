Rails.application.routes.draw do
  root to: home #index"
  resources :menus
  resources :menu_items
  resources :orders
  resources :order_items
  resources :users
  put "/orders/rating", to: "orders#rating", as: :order_rating
  get "orders/all", to: "orders#all_orders", as: :all_orders
  get "/cart", to: "orders#cart", as: "cart"
  get "/pending_orders", to: "orders#pending_orders", as: "pending_orders"
  get "/sign_in", to: "sessions#new", as: :new_session
  post "/sign_in", to: "sessions#create", as: :session
  delete "/sign_out", to: "sessions#destroy", as: destroy_session
end
