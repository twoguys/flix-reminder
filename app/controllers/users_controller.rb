class UsersController < ApplicationController

  def create_or_login
    omniauth = request.env["omniauth.auth"]
    user = User.find_by_netflix_id(omniauth["uid"])
    if user.nil?
      user = User.new(netflix_id: omniauth["uid"])
    end
    user.first_name = omniauth["user_info"]["first_name"]
    user.last_name = omniauth["user_info"]["last_name"]
    user.email = session[:email]
    user.day_of_the_week = session[:day_of_the_week]
    user.token = ActiveSupport::SecureRandom.hex(24)
    user.oauth_token = omniauth["credentials"]["token"]
    user.oauth_secret = omniauth["credentials"]["secret"]
    user.save!
    
    session[:user_id] = user.id
    user.activate!
    redirect_to settings_path
    
    rescue Exception => e
      render text: e.message
  end

  def authorize_netflix
    @user = User.new(params[:user])
    if @user.email.blank?
      redirect_to root_path, alert: "Please provide an email address" and return
    end
    
    session[:day_of_the_week] = @user.day_of_the_week
    session[:email] = @user.email
    redirect_to '/auth/netflix'
  end

  def failure
    render text: params[:message]
  end
  
  def settings
    redirect_to root_path and return if current_user.nil?    
    @user = current_user
  end
  
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
  
  def send_email
    FlixQueueMailer.send_queue(current_user,current_user.get_movies).deliver
  end

end