  class PostsController < ApplicationController
    before_action :set_post, only: %i[ show edit update destroy ]
    before_action :authenticate_user!, except: [ :index, :show ]
    include Pagy::Backend
    include Pagy::Frontend

    # GET /posts or /posts.json
    def index
      if current_user&.isAdmin?
        @pagy, @posts = pagy(Post.order(created_at: :desc).order(publication_date: :desc), limit: 10)
      else
        @pagy, @posts = pagy(current_user.posts.order(publication_date: :desc), limit: 6)
      end
    end

    # GET /posts/1 or /posts/1.json
    def show
      @post = Post.find(params[:id])
    end

    # GET /posts/new
    def new
      @post = Post.new
    end

    # GET /posts/1/edit
    def edit
      @post = Post.find(params[:id])
    end

    # POST /posts or /posts.json
    def create
      if current_user&.isAdmin == false

        @post = current_user.posts.new(post_params)
        @post.active = true
        @post.featured = false
        @post.publication_date = Date.today

        respond_to do |format|
          if @post.save
            format.turbo_stream do
              render turbo_stream: turbo_stream.prepend("posts", partial: "posts/post", locals: { post: @post })
            end
            format.html { redirect_to @post, notice: "Post was successfully created." }
            format.json { render :show, status: :created, location: @post }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to posts_path, alert: "Admin cannot create posts."
      end
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
      if @post.user_id == current_user.id
        allowed_params = params.require(:post).permit(:title, :content)

        respond_to do |format|
          if @post.update(allowed_params)
            format.turbo_stream do
              render turbo_stream: turbo_stream.update("post_#{@post.id}", partial: "posts/post", locals: { post: @post })
            end

            format.html { redirect_to @post, notice: "Post was successfully updated." }
            format.json { render :show, status: :ok, location: @post }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end

      elsif current_user&.isAdmin? && @post.user_id != current_user.id
        allowed_params = params.require(:post).permit(:active, :featured)

        respond_to do |format|
          if @post.update(allowed_params)
            format.turbo_stream do
              render turbo_stream: turbo_stream.update("post_#{@post.id}", partial: "posts/post_rows", locals: { post: @post })
            end
            format.html { redirect_to @post, notice: "Post was successfully updated." }
            format.json { render :show, status: :ok, location: @post }
          else
            respond_to do |format|
              format.html { redirect_to @post, notice: "You cannot edit user post's contents." }
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @post.errors, status: :unprocessable_entity }
            end
          end
        end
      else
        redirect_to posts_path, alert: "You are not allowed to update other user's posts."
      end
    end

    # DELETE /posts/1 or /posts/1.json
    def destroy
      if @post.user_id != current_user.id
        redirect_to posts_path, alert: "You are not allowed to delete other user's posts"
      else
        @post.destroy!

        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.remove()
          end
          format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
          format.json { head :no_content }
        end
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def post_params
        params.require(:post).permit(:title, :content, :active, :featured, :publication_date)
      end
  end
