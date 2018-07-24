Rails.application.routes.draw do
  resources :templates

  root to: 'templates#index'
end
