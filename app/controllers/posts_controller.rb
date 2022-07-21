class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 2)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user.posts }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
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

  def like
    @post = Post.find(params[:id])
    Like.new(author_id: current_user.id, post_id: @post.id).save
    redirect_to user_post_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @post.destroy
    redirect_back(fallback_location: root_path)
  end
end
