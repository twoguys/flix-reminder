class FlixQueueMailer < ActionMailer::Base
  default from: "Flix Reminder <guys@flixreminder.com>"
  default_url_options[:host] = ENV['ASSET_HOST']

  def send_queue(user, movies)
    @first      = movies.first
    @movies     = movies.slice(1..movies.length)
    @asset_host = ENV["ASSET_HOST"]
    @user       = user
    
    unless @movies.empty?
      mail to: user.email, subject: "Your next movie is #{movies.first.short_title}"
    end
  end
end
