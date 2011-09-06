class User
  include MongoMapper::Document
  devise :database_authenticatable, :rememberable

  key :netflix_id,      String
  key :email,           String
  key :first_name,      String
  key :last_name,       String
  key :token,           String
  key :day_of_the_week, Integer
  
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
  validates :day_of_the_week, presence: true
  
  before_create :create_token

  def name
    "#{first_name} #{last_name}"
  end


  private

  def create_token
    self.token = ActiveSupport::SecureRandom.hex(24)
  end

end
