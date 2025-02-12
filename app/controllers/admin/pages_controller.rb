module Admin
  class Admin::PagesController < ApplicationController
    before_action :authenticate_user!, only: %i[audit]

    def audit
        @user_audits = Audited::Audit.where(auditable_type: "User")
        @post_audits = current_user.posts.map(&:audits).flatten
        @user_associated_audits = current_user.associated_audits
        @user_own_and_associated_audits = current_user.own_and_associated_audits
    end

    def adminportal
        @pagy, @posts = pagy(Post.order(publication_date: :desc), limit: 5)
    end
  end
end
