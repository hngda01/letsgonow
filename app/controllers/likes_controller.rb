class LikesController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @liked= Like.where("user_id= ? and micropost_id = ?",params["like"]["user_id"],params[:micropost_id])
    if @liked.count == 0
    #check to add noti
    if current_user.id != @micropost.user_id
    @notification = @micropost.notifications.build(like_params) # strong parameters
    @notification.user_id = @micropost.user_id
    @notification.save
    end
    #end check
    @likes= @micropost.likes
    @like = @micropost.likes.build(params.require(:like).permit(:user_id,:micropost_id)) # strong parameters
    if @like.save
      @liked= Like.where("user_id= ? and micropost_id = ?",params["like"]["user_id"],params[:micropost_id])
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to @micropost
        end
        format.js # JavaScript response
      end    
    end
  else
    @micropost = Micropost.find(params[:micropost_id])
    @like = Like.where("user_id = ? and micropost_id = ?", params["like"]["user_id"],params[:micropost_id]).first
    @like.destroy
    @likes= @micropost.likes
    @liked= Like.where("user_id= ? and micropost_id = ?",params["like"]["user_id"],params[:micropost_id])
    respond_to do |format|
      format.html do
        flash[:success] = 'like deleted.'
        redirect_to @micropost
      end
      format.js # JavaScript response
    end
  end
  end
  def destroy

    @like = Like.find(params[:id])
    @micropost = @like.micropost
    @like.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'like deleted.'
        redirect_to @micropost
      end
      format.js # JavaScript response
    end
  end  
  private

  def like_params
    params.require(:like).permit(:notification, :user_id,:micropost_id)
  end
  
end
