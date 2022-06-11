Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: :create do
    member do
      get :posts
    end
  end

  resources :posts, only: %i(show create update)
end
