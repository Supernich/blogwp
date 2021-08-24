class PostsController < ApplicationController
  # TODO: GLOBAL: Check project with Rubocop gem and try to correct mistakes
  # using gem prawn pdf or wicker-pdf

  around_action :logs_in_console
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
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@post.title}",
               template: 'posts/show.pdf.erb',
               locals: { post: @post }
      end
    end
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

  def logs_in_console
    time_begin = Time.now
    logs = 'LOGS: Request: '
    logs += "Method: #{request.request_method}, "
    logs += "Body: #{request.body}, "
    logs += "IP: #{request.ip}, "
    yield
    logs += 'Respond: '
    logs += "Body class: #{response.body.class}, "
    logs += "Content-type: #{response.content_type}, "
    logs += "Response header class: #{response.header.class}, "
    logs += "Completed in: #{Time.now - time_begin} seconds"
    puts logs
  end

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
      msg = { status: 'ok', ip_addr: request.ip, ip_stack_api: 'a1b3e41fa2284fb6fd4db50b8629e884' }
      format.json { render json: msg }
    end
  end
end
