class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,:show]

  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
    @notifications= current_user.notifications
  end

  def show
    @user = User.find(params[:id])
    @notifications= current_user.notifications
    @microposts = @user.microposts.where("accept = ?", true).paginate(page: params[:page],per_page: 5)
    @savedMicroposts = SavePost.where("user_id = ? ", params[:id])
  end

  def new
    @user = User.new
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Viet Travel!"
      redirect_to @user
    else
      flash[:danger] = "please fill in all input fields!"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @notifications= @user.notifications
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:danger] = "please fill in all input fields!"
      redirect_to @user
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_back(fallback_location: root_path)
  end
  def following
    @notifications= current_user.notifications
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @notifications= current_user.notifications
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation,:picture,:address,:hobby,:phone_number)
    end

    # Before filters

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
