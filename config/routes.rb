Rails.application.routes.draw do
  resources :notifications do
    resources :user_subscriptions
  end

  resources :notifications do
    member do
      get 'users'
    end
  end

  resources :notifications do
    member do
      post 'send_group_notification'
    end
  end

  resources :users do
    resources :user_subscriptions
    resources :notification_events
  end

  get 'profile', to: 'profiles#edit', as: :edit_profile
  patch 'profile', to: 'profiles#update', as: :update_profile

  resources :users do
    member do
      get 'subscribed_notifications'
      get 'notifications'
      get 'unread_notifications'
      get 'read_notifications'
    end
  end

  post 'subscribe', to: 'subscribe#show'
  post 'confirm', to: 'subscribe#confirm'

  post 'authenticate', to: 'authentication#authenticate'

  post 'auth/:provider/callback', to: 'sessions#create'
  get 'link_success', to: 'sessions#link_success'
  get 'error', to: 'sessions#error'
end
