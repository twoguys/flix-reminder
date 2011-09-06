class User
  include MongoMapper::Document
  devise :database_authenticatable, :rememberable

  key :netflix_id,      String
  key :email,           String
  key :first_name,      String
  key :last_name,       String
  key :day_of_the_week, Integer
  
  validates :email, presence: true, uniqueness: true
  validates :day_of_the_week, presence: true
  
  def name
    "#{first_name} #{last_name}"
  end

end
