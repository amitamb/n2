class TagsController < ApplicationController
  def suggest
		q = params[:query]
		suggestions = ActsAsTaggableOn::Tag.find(:all, :select => :name, :conditions => ["name like ?", "#{q}%"] ).collect { |t| t.name }
		render :json => { :query => q, :suggestions => suggestions }
  end
end
