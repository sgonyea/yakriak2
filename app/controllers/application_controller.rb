class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :do_intro, :except => [:welcome, :login]
  
  def do_intro
    if cookies[:name].blank?
      render :action => "welcome"
    end
  end
end
