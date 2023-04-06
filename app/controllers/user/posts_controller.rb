class User::PostsController < ApplicationController
#before_action :ensure_item, only: [:show, :edit, :update]
#メンターにきく
  
 def new
  @post = Post.new
 end
 
  #postの新規投稿
 def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id
  if @post.save
   redirect_to post_path(@post)
  else
   @posts = Post.all
   render :index
  end
 end
  
 def show
  @post = Post.find(params[:id])
 end

 def edit
  @post = Post.find(params[:id])
 end
 
 def update
  @post = Post.find(params[:id])
 end
 
 def index
  @posts = Post.all
 end
  
private

 def post_params
  params.require(:post).permit(:item_name, :item_description)
 end

  
end


