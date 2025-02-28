module Site
  class CommentsController < SiteController
    before_action :authenticate_customer!
    before_action :set_post
    before_action :set_comment, only: [ :destroy ]

    def create
      @comment = @post.comments.build(comment_params)
      @comment.customer = current_customer

      respond_to do |format|
        if @comment.save
          format.turbo_stream do
            render turbo_stream: turbo_stream.prepend("post_#{@post.id}_comments", partial: "site/comments/comments_list", locals: { post: @post })
          end
          format.html { redirect_to site_post_path(@post), notice: "Comment added successfully!" }
        else
          format.html { redirect_to site_post_path(@post), notice: "Cannot create comment." }
        end
      end
    end

    def destroy
      if @comment.customer == current_customer
        @comment.destroy

        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.remove("comment_#{@comment.id}") }
          format.html { redirect_to site_post_path(@post), notice: "Comment deleted successfully!" }
        end
      else
        redirect_to site_post_path(@post), alert: "You can only delete your own comments!"
      end
    end
    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = @post.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
  end
end
