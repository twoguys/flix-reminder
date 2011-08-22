class UsersController < ApplicationController

  def create_or_login
    #render text: request.env['omniauth.auth']
    omniauth = request.env["omniauth.auth"]
    user = User.find_or_create_by_netflix_id(omniauth["uid"])
    Rails.logger.info user.inspect
    if user.first_name.blank? || user.last_name.blank?
      user.update_attributes(first_name: omniauth["user_hash"]["first_name"], last_name: omniauth["user_hash"]["last_name"])
    end
    sign_in_and_redirect(:user, user)
  end

  def failure
    render text: params[:message]
  end


end