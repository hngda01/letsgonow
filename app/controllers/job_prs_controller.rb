class JobPrsController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    
    #new comment 
    #check to add notification
    if current_user.id != params[:micropost_id]   
    @notification = @micropost.notifications.build(params.require(:job_pr).permit(:notification,:user_id,:micropost_id)) # strong parameters
    @notification.user_id= @micropost.user_id
    @notification.save
    end
    #end check
    @pr = @micropost.job_prs.build(pr_params) # strong parameters
    if @pr.save
      flash[:success] = "Micropost created!"
      redirect_to @micropost
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

    def pr_params
      params.require(:job_pr).permit(:pr,:user_id,:micropost_id)
    end
end
