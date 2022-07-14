class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 2)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    @post = Post.new(post_params)
    @user = current_user
    if @post.save
      puts 'Post created successfully'
      redirect_to user_posts_path(current_user)
    else
      render :new, alert: 'Error occured!'
    end
  end

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end
end
