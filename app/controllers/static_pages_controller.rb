class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @notifications= current_user.notifications
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def admin
    if current_user.admin == false
      redirect_to not_allow_path
    end
    @notifications= current_user.notifications
    @waitingPost = Micropost.where("accept = ?", false)
    #@waitingPost = Micropost.paginate(page: params[:page])
  end
  def slider
    @notifications= current_user.notifications
    if logged_in?
      @sliders  = Slider.all
    end
  end
  def not_allow
    @notifications= current_user.notifications
  end
  def adminuser
    if current_user.admin == false
      redirect_to not_allow_path
    end
    @static_pages = User.paginate(page: params[:page])
    @notifications= current_user.notifications
    @waitingPost = Micropost.where("accept = ?", false)
    #@waitingPost = Micropost.paginate(page: params[:page])
  end

  def about
    @recentPosts= Micropost.where("district_id = ?",params[:id])
    @notifications= current_user.notifications
    respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to about_path
        end
        format.js
    end
    
  end

  def deletep
    @post= Micropost.find(params[:id])
    @post.destroy
    redirect_back(fallback_location: root_path)
  end
  def acceptp
    @post= Micropost.find(params[:id])
    @post.accept= true
    @post.save
    redirect_back(fallback_location: root_path)
  end
  def setadmin
    @user= User.find(params[:id])
    @user.admin= true
    @user.save
    redirect_back(fallback_location: root_path)
  end
  def searchp
    redirect_to searchpeople_path(:id => params[:search])
  end
  def searchpeople
    @notifications= current_user.notifications
    wildcard_search = params[:id]
    @recentPosts= Micropost.where("title like ? and accept = ?","%#{wildcard_search}%",true).paginate(page: params[:page],per_page: 5)
  end
  def index
    if logged_in?
    @notifications= current_user.notifications
    end
    @posts= Like.group('micropost_id').order('count(id) desc').limit(5)
    @addresses= District.all
    @recentPosts= Micropost.where("accept = ?", true).order("updated_at DESC").paginate(page: params[:page], per_page: 5)    
    @topUsers= User.joins(:microposts).group('users.id').order('count(microposts.id) desc').limit(10)
  end
end
