Rails.application.routes.draw do
  root "pages#homepage"

  draw :admin
  draw :site
end
