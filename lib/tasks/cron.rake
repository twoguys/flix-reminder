desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour == 1
    is_even_day = Time.now.yday % 2 == 0
    if is_even_day
      puts "[QueueMailer] Sending emails to users"
      total_sent = User.deliver_emails
      puts "[QueueMailer] Sent #{total_sent} emails"
    end
  end
end