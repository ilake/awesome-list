Rails.application.routes.draw do
  root to: "technologies#index"

  devise_for :users, skip: [:sessions], :controllers => { omniauth_callbacks: "callbacks" }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
  get "/new", to: "repositories#new", as: :new_repository
  get "/:technology_name/:category_name/:repository_name", to: "repositories#show", as: :repository
  get "/:technology_name/:category_name", to: "repositories#index", as: :repositories_list
  get "/:technology_name", to: "categories#index", as: :categories
  resources :repositories, only: [:create]
end
