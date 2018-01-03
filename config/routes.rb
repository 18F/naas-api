Rails.application.routes.draw do
  resources :notifications do
    resources :user_subscriptions
  end

  resources :users do
    resources :user_subscriptions
  end

  resources :users do
    member do
      get 'notifications'
    end
  end

  post 'subscribe', to: 'subscribe#send'
  post 'confirm', to: 'subscribe#confirm'

=begin
  resource :subscribe do
    member do
      post 'send'
    end
  end
=end
end