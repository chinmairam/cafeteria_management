Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get "/sign_in", to: "sessions#new", as: :new_session
  post "/sign_in", to: "sessions#create", as: :session
  delete "/sign_out", to: "sessions#destroy", as: :destroy_session
  put "/orders/rating", to: "orders#rating", as: :order_rating
  get "/orders/all", to: "orders#all_orders", as: :all_orders
  resources :menus, :menu_items, :orders, :order_items, :users
  get "/cart", to: "orders#cart", as: :cart
  get "/pending_orders", to: "orders#pending_orders", as: :pending_orders
  get "/slaes_report", to: "orders#sale", as: :order_sale
  get "search", to: "search#search", as: :search
  post "/clerk", to: "users#clerk", as: :clerk
  post "/clerk/update", to: "users#clerk_update", as: :clerk_update
end
