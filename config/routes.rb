Rails.application.routes.draw do
  resources :agencies do
    resources :notifications
  end

  resources :users do
    resources :notifications
    resources :agencies
  end
end