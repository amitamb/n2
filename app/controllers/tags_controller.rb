class TagsController < ApplicationController

	skip_before_filter :set_iframe_status
  skip_before_filter :set_p3p_header
  skip_before_filter :set_current_tab
  skip_before_filter :set_current_sub_tab
  skip_before_filter :set_ad_layout
  skip_before_filter :set_locale
  skip_before_filter :set_outbrain_item
  skip_before_filter :set_auto_discovery_rss
  skip_before_filter :update_last_active
  skip_before_filter :check_post_wall
  skip_before_filter :verify_request_format

  def suggest
		q = params[:query]
		suggestions = ActsAsTaggableOn::Tag.find(:all, :select => :name, :conditions => ["name like ?", "#{q}%"] ).collect { |t| t.name }
		render :json => { :query => q, :suggestions => suggestions }
  end
end
