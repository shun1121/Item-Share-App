class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end
  
  # GET /posts/1
  # GET /posts/1.json
  def show
    @profile = Profile.find_by(:user_id => current_user.id)
    user = Post.find_by(:id => params[:id])
    @user_name = Profile.find_by(:user_id => user.user_id)
    # print("==========================")
    # print(@user_name.name)
    
    if !Text.where("post_id" =>  params[:id]).nil?
      @texts = Text.where("post_id" => params[:id])
    end
    # @profiles = Profiles.where("user_id" => params[:id])
      # @texts = Text.where(:post_id => params[:id]).where(text)
    # end
  end

  # GET /posts/new
  def new
    # @post = Post.new
    @post = Post.new(:user_id => current_user.id)#Post.find_or_create_by(:user_id => current_user.id)
  end

  # GET /posts/1/edit
  def edit
    if @post.user_id != current_user.id 
      flash[:notice] = "他のユーザーの投稿は編集できません。"
      redirect_to posts_path
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '投稿が保存されました。' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: '投稿が更新されました。' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if @post.user_id != current_user.id
         flash[:notice] = "他のユーザーの投稿は削除できません。"
         redirect_to posts_path#action: :index
    else
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: '投稿が削除されました。' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :name, :thumbnail, :price, :introduction)
    end
end
