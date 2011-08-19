class UsersController < ApplicationController

  def create
    auth = request.env["rack.auth"]
    User.where(netflix_id:  auth['uid'])
    flash[:notice] = "Authentication successful."
    redirect_to root_path 
  end

end