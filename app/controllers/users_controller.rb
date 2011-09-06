class UsersController < ApplicationController

  def create_or_login
    #render text: request.env['omniauth.auth'] and return
    omniauth = request.env["omniauth.auth"]
    user = User.find_or_create_by_netflix_id(omniauth["uid"])
    Rails.logger.info user.inspect
    user.update_attributes(
      first_name: omniauth["user_info"]["first_name"], 
      last_name: omniauth["user_info"]["last_name"],
      email: session[:email],
      day_of_the_week: session[:day_of_the_week]
    )
    
    sign_in_and_redirect(:user, user)
  end

  def authorize_netflix
    session[:day_of_the_week] = params[:user][:day_of_the_week]
    session[:email] = params[:user][:email]
    redirect_to '/auth/netflix'
  end

  def failure
    render text: params[:message]
  end


end
