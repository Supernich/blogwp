class PostsController < ApplicationController
  def index
    if params[:bot] == 'yes'
      @post = Post.new(params.permit(:title, :body))
      @post.save
    end
    respond_weather if params[:weather] == 'yes'
    respond_ip if params[:get_ip] == 'yes'
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def form; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def respond_weather
    respond_to do |format|
      msg = { status: 'ok', message: '9f350cda-a320-4aaa-9413-bc9b31e2dd13' }
      format.json { render json: msg }
    end
  end

  def respond_ip
    respond_to do |format|
      msg = { status: 'ok', message: request.ip }
      format.json { render json: msg }
    end
  end
end
