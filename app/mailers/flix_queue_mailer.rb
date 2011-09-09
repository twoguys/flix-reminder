class FlixQueueMailer < ActionMailer::Base
  default from: "guys@flixreminder.com"

  def send_queue(user, movies)
    @first = movies.first
    @movies = movies.slice(1..movies.length)
    unless @movies.empty?
      mail to: user.email, subject: "Your next movie is #{movies.first.short_title}"
    end
  end
end
