Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount ActionCable.server => "/cable"
  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: %i(index create) do
    member do
      get :posts
    end
  end

  resources :posts, only: %i(index show create update destroy) do
    member do
      get :comments
    end
  end

  resources :comments, only: %i(create update destroy) do
    member do
      post :reactions
      delete 'reactions/:reaction_id', action: :delete_reactions
    end
  end
end
