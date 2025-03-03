module Admin
  class PostsController < AdminController
    before_action :set_post, only: %i[show edit update destroy]
    before_action :authenticate_user!, except: [ :index, :show ]
    include Pagy::Backend

    def index
      @has_record = Post.for_datatables.present?
      order_by_vals = params[:order_by].present? ? params[:order_by].split("_") : []
      count_per_page = params[:count_per_page].presence || 10

      @pagy, @posts = pagy(
        Post.filter(params.slice(:title, :active, :featured, :publication_date), order_by_vals).for_datatables,
        limit: count_per_page.to_i
      )
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

    def destroy
      @post.destroy!

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove("post_#{@post.id}")
        end
        format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    end


    private
      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:active, :featured)
      end
  end
end
