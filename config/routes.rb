Rails.application.routes.draw do
  root "site#homepage"

   draw :admin
   draw :site
end
