class WelcomeController < ApplicationController
  
  def index
    redirect_to settings_path and return if current_user
    @user = User.new
    @landing = true
  end
end
