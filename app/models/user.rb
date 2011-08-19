class User
  include MongoMapper::Document

  key :email, String

end