class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :asset_url
  
  def current_user
    User.find_by_id(session[:user_id])
  end
end