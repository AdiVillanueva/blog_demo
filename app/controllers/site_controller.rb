class SiteController < ApplicationController
  before_action :authenticate_customer!, except: [ :homepage ]
  include Pagy::Backend
  include Pagy::Frontend
  layout 'application'
  def homepage
    @featured_posts = Post.where.not(customer_id: nil).where.not(publication_date: nil).where(active: true).where(featured: true).where("publication_date <= ?", Date.today).limit(5)
    @pagy, @posts = pagy(Post.where.not(featured: true).where.not(customer_id: nil).where.not(publication_date: nil).where(active: true).where("publication_date <= ?", Date.today).order(publication_date: :desc), limit: 6)
  end
end
