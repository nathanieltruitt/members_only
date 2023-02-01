class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.all
    respond_to do |format|
      format.html { render :index, status: :ok }
      format.json { render json: @posts, status: :ok }
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.users_id = current_user.id
    if @post.save
      respond_to do |format|
        format.html { redirect_to posts_path, status: :created, location: @post }
        format.json { render json: @post, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Successfully updated post!'
      respond_to do |format|
        format.html { redirect_to posts_path, status: 303, location: @post }
        format.json { render json: @post, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, status: :ok }
      format.json { head :no_content }
    end
  end

  def my_posts
    @posts = Post.where(users_id: current_user.id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    post = Post.find(params[:id])
    if post.users_id == current_user.id
      @post = post
    else
      flash[:alert] = '401 Unauthorized'
      respond_to do |format|
        format.html { redirect_to posts_path, status: :unauthorized }
        format.json { render json: 'UnAuthorized', status: :unauthorized}
      end
    end
  end
end