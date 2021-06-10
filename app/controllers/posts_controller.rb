class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :owner, :destroy, :update]
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
    json = @post.as_json.merge({
      images: @post.post_pictures.attachments.map do |attachment|
        url_for(attachment)
      end,
      owner: @post.owner.as_json,
    })

    render json: json
  end

  # POST /posts
  def create
    @user = current_user
    @city = City.where(name:post_params[:city]).first

    @post = Post.new(
      title: post_params[:title],
      content: post_params[:content],
      price: post_params[:price],
      owner: @user,
      city_id: @city.id
    )

    @post.post_pictures.attach(post_params[:images])

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update

    @user = current_user
    if @post.update(
      title: post_params[:title],
      content: post_params[:content],
      price: post_params[:price]
    )

      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  def owner
    
    @posts = Post.where(owner: current_user)
    json = @posts.as_json

    render json: json
  end



  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.permit(:post, :id, :title, :content, :price, :city, :data, images: [])
  end
end
