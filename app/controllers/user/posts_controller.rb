class User::PostsController < ApplicationController
 before_action :authenticate_user!

 def new
  @post = Post.new
  @tag = Tag.all
 end
 
 def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id
  if @post.save
    params[:post][:tag_ids].each do |tag|
     @post.post_tags.create!(tag_id: tag)
    end
     redirect_to post_path(@post)
  else
   @posts = Post.all
   render :index
  end
 end
  
 def show
  @post = Post.find(params[:id])
  #コメント機能の記述
  @post_comment = PostComment.new
  @post_tags = @post.tags
  @user = @post.user
 end
 


 def edit
  @post = Post.find(params[:id])
 end
 
 def update
  @post = Post.find(params[:id])
  if @post.update(post_params)
  redirect_to post_path(@post)
  else
  @posts = Post.all
  render :index
  end
 end
 
 
 def index
  @posts = Post.all.page(params[:page])
  #@posts = Post.all
  @message = "何も投稿されていません。投稿してみましょう！" if @posts.empty?
 end
 
 def destroy
  @post = Post.find(params[:id])
  if @post.destroy
  flash[:notice] = "投稿は削除されました."
  redirect_to posts_path
  else
  posts = Post.all
  render 'index'
  end
 end
 
 # 投稿の検索メソッド
 #searchコントローラーの実装で消す。一旦残してるだけ。
 def search
  if params[:item_name].present?
     @posts = Post.where('item_name LIKE ?', "%#{params[:item_name]}%")
  else
     @posts = Post.none
  end
 end

 
 private

 def post_params
  params.require(:post).permit(:item_name, :item_description, :image)
 end


end

def index
 
end