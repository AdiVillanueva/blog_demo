class PagesController < ApplicationController
    before_action :authenticate_user!, only: %i[audit]
    def homepage
        @featured_posts = Post.where.not(user_id: nil).where.not(publication_date: nil).where(active: true).where(featured: true).where("publication_date <= ?", Date.today).limit(5)
        @posts = Post.where.not(user_id: nil).where.not(publication_date: nil).where(active: true).where("publication_date <= ?", Date.today).order(publication_date: :desc)
    end

    def audit
        @user_audits = Audited::Audit.where(auditable_type: "User")
        @post_audits = current_user.posts.map(&:audits).flatten
        @user_associated_audits = current_user.associated_audits
        @user_own_and_associated_audits = current_user.own_and_associated_audits
    end
end
