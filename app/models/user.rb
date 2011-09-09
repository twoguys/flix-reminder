class User
  include MongoMapper::Document
  include AASM

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

  def name
    "#{first_name} #{last_name}"
  end
  
  def get_movies
    Flixy.configure do |config|
      config.oauth_token        = self.oauth_token
      config.oauth_token_secret = self.oauth_secret
    end
    
    user = Flixy::User.find(self.netflix_id)
    user.queue(:disc, max_results: "5").items
  end
  
  def send_queue
    FlixQueueMailer.send_queue(self, self.get_movies).deliver
  end
  
  def self.deliver_emails_for_day(day = Date.today.cwday)
    users = User.find_all_by_day_of_the_week_and_state(day, "active")
    users.each { |user| user.send_queue }
    users.size
  end

end
