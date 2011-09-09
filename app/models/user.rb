class User
  include MongoMapper::Document
  include AASM

  key :netflix_id,      String
  key :email,           String
  key :first_name,      String
  key :last_name,       String
  key :token,           String
  key :day_of_the_week, Integer
  
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
  validates :day_of_the_week, presence: true

  aasm_state :passive
  aasm_state :active
  aasm_state :suspended

  aasm_initial_state :passive
  
  aasm_event :activate do
    transitions :to => :active, :from => [:passive,:suspended]
  end
  
  aasm_event :suspend do
    transitions :to => :suspended, :from => :active
  end

  def name
    "#{first_name} #{last_name}"
  end

end
