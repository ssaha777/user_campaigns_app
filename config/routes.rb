Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"

  resources :users, only: [:index, :new]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create] do
        collection do
          get 'filter'
        end
      end
    end
  end
end
