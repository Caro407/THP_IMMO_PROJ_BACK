class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create]
  before_action :authenticate_user, only: [:index]

  # GET /posts
  def index
    @posts = Post.all
    json = @posts.to_a.map! do |post|
      post.as_json.merge({
        images: post.post_pictures.attachments.map do |attachment|
          url_for(attachment)
        end,
      })
    end

    render json: json
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @user = current_user

    @post = Post.new(
      title: post_params[:title],
      content: post_params[:content],
      price: post_params[:price],
      owner: @user,
    )
    debugger
    @post.post_pictures.attach(post_params[:image])
    debugger

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.permit(:title, :content, :price, :image, :data)
  end
end
