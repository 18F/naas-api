Rails.application.routes.draw do
  resources :agencies do
    resources :notifications
  end
end