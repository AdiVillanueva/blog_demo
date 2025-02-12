module Site
  class Site::PagesController < ApplicationController
    before_action :authenticate_user!, except: [ :homepage ]
    include Pagy::Backend
    include Pagy::Frontend
    def homepage
      @featured_posts = Post.where.not(user_id: nil).where.not(publication_date: nil).where(active: true).where(featured: true).where("publication_date <= ?", Date.today).limit(5)
      @pagy, @posts = pagy(Post.where.not(user_id: nil).where.not(publication_date: nil).where(active: true).where("publication_date <= ?", Date.today).order(publication_date: :desc), limit: 6)
    end
  end
end
