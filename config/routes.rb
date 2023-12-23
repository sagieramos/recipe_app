# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :foods
  resources :recipes do
    resources :recipe_foods
    member do
      patch 'toggle_public'
      post 'choose_inventory', to: 'recipes#choose_inventory'
    end
  end

  resources :inventories, except: [:update, :edit] do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end

  get 'public_recipes', to: 'recipes#public_recipes'
  get 'shopping_list', to: 'inventories#shopping_list'


  root 'inventories#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
end
