Rails.application.routes.draw do
  
  #required for sidekiq to work
  require 'sidekiq/web'
  mount Sidekiq::Web => 'sidekiq'

  #braintree payment system
  get 'braintree/new'
  post 'braintree/checkout'

  # path to pass params to braintree payment
  get 'reservations/:id/braintree/new' => "braintree#new", as: :new_payment
  resources :users
  resources :reservations
  resources :listings
  root 'listings#index'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  resources :users, only: [:create] do
  resource :password,
	controller: "clearance/passwords",
	only: [:create, :edit, :update]
  end





  # get "/*lost" => "listings#lost"
  
end

