module Admin
  class PostsController < AdminController
    before_action :set_post, only: %i[show edit update]
    before_action :authenticate_user!, except: [ :index, :show ]
    include Pagy::Backend

    def index
      @has_record = Post.for_datatables.present?
      order_by_vals = params[:order_by].present? ? params[:order_by].split("_") : []
      @pagy, @posts = pagy(Post.filter(params.slice(:title, :active), order_by_vals).for_datatables, limit: 10)
    end

    def show
    end

    def edit
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
      allowed_params = params.require(:post).permit(:active, :featured)
      respond_to do |format|
        if @post.update(allowed_params)
          format.turbo_stream do
            render turbo_stream: turbo_stream.update("post_#{@post.id}", partial: "admin/posts/post_table_rows", locals: { post: @post })
          end
          format.html { redirect_to @post, notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { redirect_to @post, notice: "You cannot edit user post's contents." }
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end


    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def post_params
        params.require(:post).permit(:active, :featured)
      end
  end
end
