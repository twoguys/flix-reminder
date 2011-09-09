module Flixy
  class Queue
    include Flixy::API
    
    attr_accessor :user_id, :etag, :items, :queue_type, :params
    
    def self.find(user_id, queue_type, opts = {})
      queue             = Queue.new
      queue.queue_type  = queue_type
      queue.user_id     = user_id
      queue.params     = opts
      
      queue.fetch(queue_type)
    end
    
    def move_to_position(item, position = 1)
      response = post(
        "/users/#{self.user_id}/queues/#{queue_type}",
        title_ref: item.item_id,
        position: position, 
        etag: etag
      )
      self.etag = response.status.etag
      response.status.status_code == "201"
    end
    
    
    def fetch(queue_type)
      response = 
        case self.queue_type
        when :disc
          get("/users/#{self.user_id}/queues/disc", self.params)
        when :instant
          get("/users/#{self.user_id}/queues/instant", self.params)
        else
          raise "Queue must be either :disc or :instant"
        end
        
      self.etag   = response.queue.etag
      self.items  = []
      
      response.queue.queue_item.each do |netflix_item|
        item = Item.new
        item.item_id        = netflix_item.id
        item.position       = netflix_item.position
        item.short_title    = netflix_item.title.short
        item.regular_title  = netflix_item.title.regular
        item.updated        = netflix_item.updated
        item.title_ref      = netflix_item.link.find do |link| 
          link.rel == Item::TITLE_SCHEMA
        end.href
        
        box_art             = BoxArt.new
        box_art.small_url   = netflix_item.box_art.small
        box_art.medium_url  = netflix_item.box_art.medium
        box_art.large_url   = netflix_item.box_art.large
        item.box_art        = box_art
        
        self.items << item
      end
      
      self
    end
    
  end
end
