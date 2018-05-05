Rails.application.routes.draw do


  root to: 'pages#home'
  devise_for :users

  resources :users, only: [:index, :show] do
    resources :pets, only: [:new, :create]
    resources :reviews, only: [:new, :create]
    resources :services, only: [:new, :create]
      member do
        put :upvote
    end
  end

  resources :pets, only: [:index, :show, :edit, :update, :destroy]
  resources :reviews, only: [:index, :show, :edit, :update, :destroy]
  resources :user_tasks
  resources :services, only: [:index, :show, :edit, :update, :destroy] do
    member do
        put :toggle
        put :toggle_pay_authorized, as: 'authorized'
    end
  end

  resources :orders, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end

end



