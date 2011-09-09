desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour == 1
    day_of_the_week = Date.today.cwday
    puts "[QueueMailer] Sending emails to users on #{day_of_the_week}"
    total_sent = User.deliver_emails_for_day(day_of_the_week)
    puts "[QueueMailer] Sent #{total_sent} emails"
  end
end