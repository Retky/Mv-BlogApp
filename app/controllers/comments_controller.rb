class CommentsController < ApplicationController
  def index
    if request.format == :json
      render json: Comment.all
    else
      render plain: '404 Not Found'
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(author_id: current_user.id, post_id: @post.id, text: params[:comment])
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      render :show, alert: 'Error occured!'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end
end
