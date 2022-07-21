Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
    get "/posts/:id/comments", to: "comments#index", as: :comments
    post "/posts/:id/like", to: "posts#like", as: :like
  end
end
