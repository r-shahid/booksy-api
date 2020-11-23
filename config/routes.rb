Rails.application.routes.draw do
  resources :books
  resource :users, only: [:create, :show, :destroy]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  get "/is_reading", to: "books#is_reading"
  get "/is_read", to: "books#is_read"
end
