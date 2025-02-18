module Site
  class PostsController < SiteController
    before_action :authenticate_customer!
    before_action :set_post, only: %i[ show edit update destroy ]

    def index
      @pagy, @posts = pagy(current_customer.posts.order(publication_date: :desc), limit: 6)
    end

    def show
      @post = Post.find(params[:id])
    end

    def new
      @post = current_customer.posts.new
    end

    def create
      @post = current_customer.posts.new(post_params)
      @post.active = true
      @post.featured = false
      @post.publication_date = Date.today

      respond_to do |format|
        if @post.save
          format.turbo_stream do
            render turbo_stream: turbo_stream.prepend("posts", partial: "site/posts/post", locals: { post: @post })
          end
          format.html { redirect_to @post, notice: "Post was successfully created." }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @post = current_customer.posts.find(params[:id])
    end

    def update
      if @post.customer_id == current_customer.id
        allowed_params = params.require(:post).permit(:title, :content)

        respond_to do |format|
          if @post.update(allowed_params)
            format.turbo_stream do
              render turbo_stream: turbo_stream.update("post_#{@post.id}", partial: "site/posts/post", locals: { post: @post })
            end
            format.html { redirect_to @post, notice: "Post was successfully updated." }
            format.json { render :show, status: :ok, location: @post }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    def destroy
      if @post.customer_id != current_customer.id
        redirect_to posts_path, alert: "You are not allowed to delete other user's posts"
      else
        @post.destroy!

        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.remove("post_#{@post.id}")
          end
          format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
          format.json { head :no_content }
        end
      end
    end

    private

    def set_post
      @post = current_customer.posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :active, :featured, :publication_date)
    end
  end
end
