Rails.application.routes.draw do
  devise_for :customers,
   path: "customers",
   controllers: {
    sessions: "site/sessions",
    registrations: "site/registrations",
    passwords: "site/passwords"
  },
  path_names: {
    sign_in: "/login",
    password: "/forgot",
    confirmation: "/confirm",
    unblock: "/unblock",
    registration: "/register",
    sign_out: "/logout",
    password_expired: "/password-expired"
  }

  namespace :site, path: "/" do
    resources :posts do
      post "like", to: "likes#create", as: "like"
      delete "like", to: "likes#destroy", as: "unlike"
      resources :comments, only: [ :create, :destroy ]
    end
    get "home", to: "site#homepage"
  end
end
