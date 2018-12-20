class BlogsController < ApplicationController

  before_action :move_to_index, except: [:index,:show]

  def index
    @blogs = Blog.order("created_at DESC")
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(text: blog_params[:text], user_id: current_user.id)
    if @blog.save
      redirect_to action: :index
    else
      redirect_to action: :new
    end
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy if blog.user_id == current_user.id
    redirect_to action: :index
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])
    blog.update(blog_params)
    redirect_to action: :index
  end

  def show
    @blog = Blog.find(params[:id])
  end

  private

  def blog_params
    params.require(:blog).permit(:text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
