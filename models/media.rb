require_relative './size'

class Medium
	include MongoMapper::Document

	key :display_url, String
	key :media_url, String
	key :id_str, String
	key :media_url_https, String
	key :expanded_url, String
	key :url, String
	key :type, String
	key :id, Integer
	key :indices, Array
	key :size_ids, Array

	many :sizes, :in => :size_ids

	key :tweet_id, ObjectId

	belongs_to :tweet
  

  	def self.new_from_raw(media, tweet_id)
    		media 		    = Hashie::Mash[media]
    		obj 		    = self.new
    		obj.display_url     = media["display_url"]
    		obj.media_url       = media["media_url"]
    		obj.id_str          = media["id_str"]
    		obj.media_url_https = media["media_url_https"]
    		obj.expanded_url    = media["expanded_url"]
    		obj.url             = media["url"]
    		obj.type            = media["type"]
    		obj.id              = media["id"]
    		obj.indices         = media["indices"]
    
		media["sizes"].each_pair do |size_type, size_data|
      			size = Size.new_from_raw(size_type, size_data, obj._id)
      			obj.sizes << size
		end
    
		obj.tweet_id = tweet_id
    		obj.save!
    		obj
  	end
end
