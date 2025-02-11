class Api::V1::PostsController < Api::BaseController
  include Authenticable
  before_action :set_post, only: [ :show, :update, :destroy ]

  def index
    @posts = Post.all
    posts = posts.where("LOWER(title) LIKE ?", "%#{params[:title].downcase}%") if params[:title].present?

  # Filter by date range
  if params[:start_date].present? && params[:end_date].present?
    posts = posts.where(created_at: params[:start_date]..params[:end_date])
  end

  # Apply pagination
  posts = posts.page(params[:page]).per(params[:per_page] || 10)

  render json: {
    posts: posts,
    meta: {
      total_pages: posts.total_pages,
      current_page: posts.current_page,
      next_page: posts.next_page,
      prev_page: posts.prev_page
    }
  }
  end

  def show
    render json: @post
  end

  def create
    @post = @current_user.posts.build(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
