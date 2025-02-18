module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    include Pagy::Backend
    include Pagy::Frontend

    def audit
    end

    def adminportal
        @pagy, @posts = pagy(Post.order(publication_date: :desc), limit: 5)
    end
  end
end
