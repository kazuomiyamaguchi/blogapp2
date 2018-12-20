class BlogsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @blogs = Blog.order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to action: :index
    else
      redirect_to action: :new
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
