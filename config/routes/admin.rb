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
    unlock: "/unblock",
    registration: "/register",
    sign_up: "/new",
    sign_out: "/logout",
    password_expired: "/password-expired"
  }

namespace :admin do
  resources :posts
end
