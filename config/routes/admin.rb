Rails.application.routes.draw do
  devise_for :users,
    path: "admin",
    controllers: {
    sessions: "admin/sessions",
    registrations: "admin/registrations",
    passwords: "admin/passwords"
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


  namespace :admin, path: "/admin" do
    resources :posts, only: [ :index, :update ]
    get "audits", to: "audit#index"
  end
end
