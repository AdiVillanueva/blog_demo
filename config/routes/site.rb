Rails.application.routes.draw do
  resources :posts


  namespace :site, path: "/" do
    root to: "pages#homepage"
  end
end
