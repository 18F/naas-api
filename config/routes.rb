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
end