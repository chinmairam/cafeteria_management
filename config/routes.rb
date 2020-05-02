Rails.application.routes.draw do
  get "/" => "home#index"
  resources :menus
  resources :menu_items
  resources :users
  resources :orders
  resources :order_items
end
