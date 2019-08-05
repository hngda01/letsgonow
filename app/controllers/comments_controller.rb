class CommentsController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    if params["comment"]["comment"] == "==delete=="
      @comment = Comment.where("id= ?",params[:comment_id]).first
      @comment.destroy
      @comments= Comment.where("micropost_id = ?",params[:micropost_id])
      respond_to do |format|
        format.html do
          redirect_to @micropost
        end
        format.js # JavaScript response
      end
    else
    #new comment 
    #check to add notification
    if current_user.id != params[:micropost_id]   
    @notification = @micropost.notifications.build(params.require(:comment).permit(:notification,:user_id,:micropost_id)) # strong parameters
    @notification.user_id= @micropost.user_id
    @notification.save
    end
    #end check
    @comments= Comment.where("micropost_id = ?",params[:micropost_id])
    @comment = @micropost.comments.build(comment_params) # strong parameters
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to @micropost
        end
        format.js # JavaScript response
      end
    end
    #end new comment
    end
  end
  def destroy

    @comment = Comment.find(params[:id])
    @micropost = @comment.micropost
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Comment deleted.'
        redirect_to @micropost
      end
      format.js # JavaScript response
    end
  end  
  private

    def comment_params
      params.require(:comment).permit(:comment,:user_id,:micropost_id)
    end
end
