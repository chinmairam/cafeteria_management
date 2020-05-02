Rails.application.routes.draw do
  resources :menus
  resources :menu_items
  resources :orders
  resources :order_items
  resources :users
  get "/" => "home#index"
  get "/sign_in", to: "sessions#new", as: :new_session
  post "/sign_in", to: "sessions#create", as: :session
end
