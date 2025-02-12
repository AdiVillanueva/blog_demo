Rails.application.routes.draw do
   draw :admin
   draw :site

  root "pages#homepage"
end
