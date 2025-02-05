Rails.application.routes.draw do
  devise_for :customers
  root "pages#homepage"

  draw :admin
  draw :site
end
