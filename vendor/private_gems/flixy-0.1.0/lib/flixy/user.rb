module Flixy
  class User
    include Flixy::API
    
    attr_accessor :user_id, :oauth_token, :oauth_token_secret, :first_name, 
                  :last_name, :nickname, :can_instant_watch

    def self.find(user_id)
      user = User.new
      user.fetch(user_id)
      user
    end



    def queue(queue_type, opts = {})
      Queue.find(self.user_id, queue_type, opts)
    end

    def fetch(user_id)
      self.user_id = user_id
      raise "You need to set user id!" unless self.user_id
      response = get("/users/#{self.user_id}")

      netflix_user            = response.user
    
      self.first_name         = netflix_user.first_name
      self.last_name          = netflix_user.last_name
      self.nickname           = netflix_user.nickname
      self.can_instant_watch  = netflix_user.can_instant_watch == 'true' ? true : false
      self
    end
    
  end
end  
