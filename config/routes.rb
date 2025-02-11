Rails.application.routes.draw do
  get "users/show"
  devise_for :users
  get "profile", to: "users#show", as: :profile
  resources :posts
  resources :users, only: [ :show, :edit, :update ]
  root "users#show"

  namespace :admin do
      resources :users, only: [ :index, :show, :edit, :update, :destroy ]
  end

  namespace :api do
    namespace :v1 do
      resources :posts, only: [ :index, :show, :create, :update, :destroy ]
    end
  end
end
