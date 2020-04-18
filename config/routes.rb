Rails.application.routes.draw do
  get "/" => "home#index"
  get "users", to: "users#index"
end
