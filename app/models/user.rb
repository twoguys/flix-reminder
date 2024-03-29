class User
  include MongoMapper::Document
  
  key :netflix_id,      String
  key :email,           String
  key :first_name,      String
  key :last_name,       String
  key :token,           String
  key :oauth_token,     String
  key :oauth_secret,    String
  key :state,           String, default: "passive"
  key :day_of_the_week, Integer
  
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
  validates :day_of_the_week, presence: true

  # aasm_state :passive
  # aasm_state :active
  # aasm_state :suspended
  # aasm_state :disabled

  def name
    "#{first_name} #{last_name}"
  end
  
  def get_movies
    flixy_user = self.flixy_user
    movies = flixy_user.queue(:disc, max_results: "5").items
    movies.reject { |movie| movie.position.nil? }
  end
  
  def send_movie_to_top(netflix_title_ref)
    flixy_user = self.flixy_user
    queue = flixy_user.queue(:disc, max_results: "5")
    items = queue.items
    requested_item = items.find { |item| item.title_ref == netflix_title_ref }
    queue.move_to_position(requested_item, 1)
    requested_item
  end
  
  def send_queue
    FlixQueueMailer.enqueue.send_queue(self.id)
  end
  
  def flixy_user
    Flixy.configure do |config|
      config.oauth_token        = self.oauth_token
      config.oauth_token_secret = self.oauth_secret
    end
    
    Flixy::User.find(self.netflix_id)
  end
  
  def self.deliver_emails_for_day(day = Date.today.cwday)
    users = User.find_all_by_day_of_the_week_and_state(day, "active")
    users.each { |user| user.send_queue }
    users.size
  end
  
  def self.deliver_emails
    users = User.all
    users.each { |user| user.send_queue }
    users.size
  end
  
  def active?
    self.state == "active"
  end

end
