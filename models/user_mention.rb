class UserMention
	include MongoMapper::Document
	
	key :screen_name, String
	key :name, String
	key :twitter_id, Integer
	key :twitter_id_str, String
	key :indices, Array
	key :tweet_id, ObjectId
	
	belongs_to :tweet


	def self.new_from_raw(entity, tweet_id)
		entity 			= Hashie::Mash[entity]
		obj                	= self.new
		obj.screen_name    	= entity["screen_name"]
		obj.name           	= entity["name"]
		obj.twitter_id     	= entity["id"]
		obj.twitter_id_str 	= entity["id_str"]
		obj.indices        	= entity["indices"]
		obj.tweet_id 		= tweet_id
		obj.save!
		obj
	end
  
end
