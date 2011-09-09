require './lib/flixy'

Flixy.configure do |config|
  config.consumer_key       = 'daf4yaewmfqn99f4pjqaems6'
  config.consumer_secret    = 'ucVXuPdrB2'
  config.oauth_token        = 'BQAJAAEDEPosQ1qPsNx2owhZ2228hUww9pzbwjij-zH2kmURp-0NUbD5hSeyqMs6hfcW9Q9lYSEhb7ZPAMgZTo8gRhprfmXC'
  config.oauth_token_secret = 'Nq4tQt7Prqsn'
end

puts "Flixy consumer key: #{Flixy.consumer_key}"
puts "Flixy consumer secret: #{Flixy.consumer_secret}"
puts "Flixy oauth token: #{Flixy.oauth_token}"
puts "Flixy oauth token secret: #{Flixy.oauth_token_secret}"


user = Flixy::User.find('T1uHQrV6AnLRiLRJWZgYiTffg7vhBrfXqHU9_HaninzPw-')

puts "User\n********\n#{user.to_yaml}\n********"

queue = user.queue(:disc, max_results: "5")
# puts "Queue\n********\n#{queue.to_yaml}\n********"
# movies = user.disc_queue.item
queue.items.each do |item|
  puts "--> (#{item.position}) #{item.regular_title} - #{item.title_ref}"
end

movie = queue.items[3]
print "\nMoving #{movie.regular_title} to position 1..."
move = queue.move_to_position(movie, 1)
puts (move ? "SUCCESS" : "FAIL")
# puts movies
