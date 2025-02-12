Rails.application.routes.draw do
  resources :posts
  devise_for :users

  namespace :admin do
  get "audits", to: "audit#index"
  get "admin", to: "pages#adminportal"
  end
end
