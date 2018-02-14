Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show, :destroy]
  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
    end

    member do
      post :restore
    end

    collection do
      delete :empty_trash
    end
  end
end
