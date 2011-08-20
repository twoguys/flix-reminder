class UsersController < ApplicationController

  def create
    render text: request.env['omniauth.auth']
    # User.where(netflix_id:  auth['uid'])
       #  flash[:notice] = "Authentication successful."
       #  redirect_to root_path 
     rescue Exception => e
       render text: e.message
  end

  def failure
    render text: params[:message]
  end


end