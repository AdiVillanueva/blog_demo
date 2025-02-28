module Site
  class LikesController < ApplicationController
    before_action :authenticate_customer!

    def create
      @post = Post.find(params[:post_id])
      @post.like_toggle(current_customer)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("post_#{@post.id}_like_button", partial: "site/posts/like_button", locals: { post: @post })
        end
        format.html { redirect_to @post }
      end
    end

    def destroy
      @post = Post.find(params[:post_id])
      @post.like_toggle(current_customer)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("post_#{@post.id}_like_button", partial: "site/posts/like_button", locals: { post: @post })
        end
        format.html { redirect_to @post }
      end
    end
  end
end
