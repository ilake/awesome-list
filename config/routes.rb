Rails.application.routes.draw do
  get "/new", to: "repositories#new", as: :new_repository
  get "/:technology_name/:category_name/:repository_name", to: "repositories#show", as: :repository
  get "/:technology_name/:category_name", to: "repositories#index", as: :repositories_list
  get "/:technology_name", to: "categories#index", as: :categories
  resources :repositories, only: [:create]

  root to: "technologies#index"
end
