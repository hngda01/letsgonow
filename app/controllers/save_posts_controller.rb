class SavePostsController < ApplicationController
	def create
	@marked= SavePost.where("user_id = ? and micropost_id = ?",current_user.id,params[:micropost_id])
    @micropost = Micropost.find(params[:micropost_id])
    if @marked.count == 0
    @savePost = @micropost.save_posts.build(save_post_params) # strong parameters
    if @savePost.save
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to @micropost
        end
        format.js # JavaScript response
      end      
    end
else
	@marked= SavePost.where("user_id = ? and micropost_id = ?",current_user.id,params[:micropost_id]).first
	@marked.destroy
	@marked= SavePost.where("user_id = ? and micropost_id = ?",current_user.id,params[:micropost_id])	
	respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to @micropost
        end
        format.js # JavaScript response
      end 
end
  end
  def destroy

    @savePost = SavePost.find(params[:id])
    @micropost = @savePost.micropost
    @savePost.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'like deleted.'
        redirect_to @micropost
      end
      format.js # JavaScript response
    end
  end  
  private

  def save_post_params
    params.require(:save_post).permit(:user_id,:micropost_id)
  end
end