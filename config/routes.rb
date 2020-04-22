Rails.application.routes.draw do
  get "/" => "home#index"
  resources :menu_items
  resources :categories
  resources :menus
  resources :users
end
