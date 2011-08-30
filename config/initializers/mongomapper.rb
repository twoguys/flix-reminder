#MongoMapper.database = "flixreminder-#{Rails.env}"

MongoMapper.config = { 
  Rails.env => { 
    'uri' => ENV['MONGOHQ_URL'] ||
    "mongodb://localhost/flixreminder-#{Rails.env}"
  }
}

MongoMapper.connect(Rails.env)

