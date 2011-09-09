module Flixy
  class Item
    attr_accessor :item_id, :position, :short_title, :regular_title, :updated, :box_art, :title_ref
    
    TITLE_SCHEMA = "http://schemas.netflix.com/catalog/title"        
  end
end