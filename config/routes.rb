# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Root route
  get '/home', to: 'nav_pages#home', as: 'home'

  # About page
  get '/about', to: 'nav_pages#about', as: 'about'

  resources :products, only: [:index, :show, :new, :create] do

    member do
      post   :buy_now
      post   :confirm_purchase
      post   :cancel_purchase
      get    :download
    end
  end

  # Creates:
  #   GET    /account/payments           -> payment_sources#index
  #   GET    /account/payments/new       -> payment_sources#new
  #   POST   /account/payments           -> payment_sources#create
  #   GET    /account/payments/:id/edit  -> payment_sources#edit
  #   PATCH  /account/payments/:id       -> payment_sources#update
  #   DELETE /account/payments/:id       -> payment_sources#destroy
  resource :account, only: %i[show edit update] do
    resources :payment_sources,
              path: 'payments',
              as:   :payments,
              only: %i[index new create destroy edit update]
  end

  # root 'products#index'
  root 'nav_pages#home'


  # Product browsing
  # get '/products', to: 'product#index', as: 'products'
  # get '/products/:id', to: 'product#show', as: 'product'
  # get '/products/:id/download', to: 'product#download', as: 'download'

  # Account pages
  # get '/account', to: 'account#index', as: 'account'
  # get '/account/new', to: 'account#new', as: 'new_account'

  # Payments
  # get '/account/payments', to: 'account#payments', as: 'payments'
  # get '/account/payments/new', to: 'account#new_payment', as: 'new_payment'
  # get '/account/payments/:id/edit', to: 'account#edit_payment', as: 'edit_payment'

  # Listings
  post 'products', to: 'products#create'
  get 'products/:id/edit', to: 'products#edit', as: 'edit_product'
  patch 'products/:id', to: 'products#update'
  delete 'products/:id', to: 'products#destroy'

  # Purchases
  get '/account/purchases', to: 'account#purchases', as: 'purchases'
  get '/account/purchases/:id', to: 'account#show_purchase', as: 'show_purchase'

  # Login and recovery

  #Commented out since we are using Devise for authentication
  # get '/login', to: 'login#index', as: 'login'
  # get '/login/forgotpass', to: 'login#forgot_pass', as: 'forgot_pass'
  # get '/login/forgotuser', to: 'login#forgot_user', as: 'forgot_user'
  # get '/login/forgotemail', to: 'login#forgot_email', as: 'forgot_email'
end
