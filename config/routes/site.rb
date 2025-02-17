devise_for :customers,
  path: "/",
  controllers: {
    sessions: "site/sessions",
    registrations: "site/registrations",
    passwords: "site/passwords"
  },
  path_names: {
    sign_in: "/login",
    password: "/forgot",
    confirmation: "/confirm",
    unlock: "/unblock",
    registration: "/reserve",
    sign_out: "/logout",
    password_expired: "/password-expired"
  }

namespace :site, path: "/" do
  # Routes for the normal users
end
