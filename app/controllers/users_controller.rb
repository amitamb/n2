class UsersController < ApplicationController
  cache_sweeper :profile_sweeper, :only => [:update_bio]
  cache_sweeper :user_sweeper, :only => [:create, :link_user_accounts]

  before_filter :login_required, :only => [:update_bio, :feed]
  before_filter :load_top_stories, :only => [:show]
  before_filter :ensure_authenticated_to_facebook, :only => :link_user_accounts

  def index
    @page = params[:page].present? ? (params[:page].to_i < 3 ? "page_#{params[:page]}_" : "") : "page_1_"
    @users = User.top.paginate :page => params[:page], :per_page => Content.per_page, :order => "karma_score desc"
    respond_to do |format|
      format.html { @paginate = true }
      format.json { @users = User.refine(params) }
    end
  end

  def feed
    render :partial => "pfeeds/pfeed_list", :locals => {:feed_collection => current_user.pfeed_inbox}, :layout => 'application'
  end

  def new
    @user = User.new
  end
 
  def create
    unless params[:user].present?
      @user = User.new
      render :new
      return false
    end
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default(home_index_path)
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def link_user_accounts
    if self.current_user.nil?
      #register with fb
      set_facebook_session unless facebook_session.present?
      User.create_from_fb_connect(facebook_session.user)
    else
      #connect accounts
      self.current_user.link_fb_connect(facebook_session.user.id) unless self.current_user.fb_user_id == facebook_session.user.id
    end
    if canvas?
      redirect_back_or_default(home_index_path(:only_path => false, :canvas => false))
    else
      redirect_back_or_default(home_index_path)
    end
  end

  def show
    @user = User.find(params[:id])
    @activities = @user.activities.paginate :page => params[:page], :per_page => 10
    @paginate = true
    @is_owner = current_user && (@user.id == current_user.id)
    respond_to do |format|
      format.html
      format.atom { @actions = @user.newest_actions }
    end
  end

  def invite
    @success = false
    if request.post?
    	if params['action'] == 'invite' and params['ids'].present?
    		flash[:notice] = "Successfully invited your friends."
    		@fb_user_ids = params['ids']
    		@success = true
    	end
    end
  end

  def update_bio    
    if request.post?
      @profile = current_user_profile
      @profile.bio = params['bio']
      if @profile.save
    		flash[:success] = "Successfully edited your bio."
    		redirect_to user_path(@profile.user)    	
      else
    		flash[:error] = "Could not update your bio."
    		redirect_to user_path(@profile.user)    	
    	end
    end
  end
  
  def account_menu
    respond_to do |format|
      format.js
    end     
  end
  
  def current
    respond_to do |format|
      format.fbjs
      format.js
      format.fbml { render :template => 'users/current.js', :content_type => 'text/javascript', :layout => false }
    end
  end

  def settings
  end

  def link_twitter_account
    
  end
end
