class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :owner, :destroy]
  before_action :authenticate_user, only: [:index]


  # GET /posts
  def index
    @posts = Post.all
    json = @posts.as_json

    if current_user
      json = @posts.to_a.map! do |post|
        post.as_json.merge({
          user: post.owner.as_json,
        })
      end
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
              owner: @user)

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
      params.require(:post).permit(:title, :content, :price)
    end
end
