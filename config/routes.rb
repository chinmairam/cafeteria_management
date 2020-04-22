Rails.application.routes.draw do
  get "/" => "home#index"
  resources :menus
  resources :users
end
