class FlixQueueMailer < ActionMailer::Base
  default from: "Flix Reminder <guys@flixreminder.com>"

  def send_queue(user, movies)
    @first = movies.first
    @movies = movies.slice(1..movies.length)
    @asset_host = ActionController::Base.asset_host
    unless @movies.empty?
      mail to: user.email, subject: "Your next movie is #{movies.first.short_title}"
    end
  end
end
