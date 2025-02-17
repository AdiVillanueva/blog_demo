module Admin
  class PostsController < AdminController
    before_action :set_post, only: %i[ show edit update ]
    def index
      @has_record = Post.for_datatables.present?
      order_by_vals = params[:order_by].present? ? params[:order_by].split("_") : []
      @posts = Post.filter(params.slice(:title, :status), order_by_vals).for_datatables
    end

    def show
    end

    def edit
    end

    def update
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :title, :content, :active, :featured, :publication_date ])
    end
  end
end
