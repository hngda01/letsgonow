class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show, :new]
  before_action :correct_user,   only: [:destroy, :update, :edit]


  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to current_user
    else
      @feed_items = []
      flash[:danger] = "failed ! input field can't be blank"
      redirect_to current_user
    end
  end
  def show
    #delete notification
    @ownNotifications= Notification.where("user_id = ? and micropost_id = ?",current_user.id,params[:id])
    @ownNotifications.each do |noti|
      noti.destroy
    end
    #end delete
    @user = User.find(current_user.id)
    @marked= SavePost.where("user_id = ? and micropost_id = ?",current_user.id,params[:id])
    @liked= Like.where("user_id= ? and micropost_id = ?",current_user.id,params[:id])
    @micropost = Micropost.find(params[:id])
    @notifications= @user.notifications
    @comments = @micropost.comments
    @likes= @micropost.likes
    @new_comment = @micropost.comments.new
    @new_like = @micropost.likes.new
    @new_save_post = @micropost.save_posts.new
  end
  
  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      flash[:success] = "Post updated"
      redirect_to @micropost
    else
      flash[:danger] = "failed ! input field can't be blank"
      redirect_to @micropost
    end
  end

  def edit
    @user = User.find(current_user.id)
    @notifications= @user.notifications
    @micropost = Micropost.find(params[:id])
    @districts = District.all
  end

  def destroy
    @user = User.find(current_user.id)
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to @user
  end
  def new
    @notifications= current_user.notifications
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
     @user = User.find(current_user.id)
     @districts = District.all
    
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture, :title, :district_id)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end