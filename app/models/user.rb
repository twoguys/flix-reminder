class User
  include MongoMapper::Document
  devise :database_authenticatable, :rememberable

  key :netflix_id, String
  key :email, String
  key :first_name, String
  key :last_name, String
  key :day_of_the_week, String
  
  validates_presence_of :email
  validates_presence_of :day_of_the_week
  validates_uniqueness_of :email
  
  def name
    "#{first_name} #{last_name}"
  end

end