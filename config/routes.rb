Rails.application.routes.draw do
  resources :themes

  resources :rounds, except: %i[edit update create] do
    member do
      get :result
    end
  end
  resources :questions do
    member do
      get :check
    end
  end
  root 'main#index'
  devise_for :users

  resources :users, only: %i[index edit update show]

  get :audit, to: 'main#audit'
end
