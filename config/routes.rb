Rails.application.routes.draw do
  resources :notifications do
    resources :user_subscriptions
  end

  resources :users do
    resources :user_subscriptions
  end

  post 'authenticate', to: 'authentication#authenticate'
end