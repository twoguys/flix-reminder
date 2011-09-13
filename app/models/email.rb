class Email
  include MongoMapper::Document
  
  key :address,       String
  key :state,         String, default: "inactive"

end