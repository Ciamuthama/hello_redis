class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post successfully created"
      redirect_to @post, notice: "Post was successfully created"
    else
      flash[:alert] = "Something went wrong"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated."
      redirect_to @post
    else
      flash[:alert] = "There were errors. Please fix them."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted"
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
