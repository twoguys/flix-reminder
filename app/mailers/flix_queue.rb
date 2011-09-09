class FlixQueue < ActionMailer::Base
  default from: "guys@flixreminder.com"

  def show_queue(user, movies)
    @first = @movies.first
    @movies.slice!(0)
    unless @movies.empty?
      mail to: user.email, subject: "Your next movie is #{movies.first.short_title}"
    end
  end
end
