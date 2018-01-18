Rails.application.routes.draw do
  resources :notifications do
    resources :user_subscriptions
  end

  resources :notifications do
    member do
      get 'users'
    end
  end

  resources :notification_events do
    member do
      get 'notification_events'
    end
  end

  resources :notifications do
    member do
      post 'send_group_notification'
    end
  end

  resources :users do
    resources :user_subscriptions
  end

  resources :users do
    member do
      get 'subscribed_notifications'
    end
  end

  resources :users do
    member do
      get 'notifications'
    end
  end

  resources :users do
    member do
      get 'unread_notifications'
    end
  end

  resources :users do
    member do
      get 'read_notifications'
    end
  end

  post 'subscribe', to: 'subscribe#show'
  post 'confirm', to: 'subscribe#confirm'

  post 'authenticate', to: 'authentication#authenticate'
end