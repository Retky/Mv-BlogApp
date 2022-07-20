Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]
    post '/users/:id/posts/new', to: 'posts#create' # create
    post '/posts/:id/comment', to: 'posts#comment', as: :comments
    post '/posts/:id/like', to: 'posts#like', as: :like
    get '/posts/:post_id/destroy', to: 'posts#destroy', as: :destroy
    get '/posts/:post_id/desroy_comment', to: 'posts#destroy_comment', as: :destroy_comment
    post '/posts/:post_id/destroy', to: 'posts#destroy' # destroy
    post '/posts/:post_id/destroy_comment', to: 'posts#destroy_comment' # destroy_comment
  end
end
