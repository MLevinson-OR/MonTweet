require './lib/include'

class Tweet
	include MongoMapper::Document
	
	key :tweet_created_at, Time
        key :tweet_id, Integer
        key :tweet_id_str, String	
	key :tweet_coordinates, Array
	key :tweet_text, String

	key :user_created_at, Time
        key :user_id, Integer
        key :user_id_str, String
	key :user_screen_name, String
	key :user_geo_enabled, Boolean
	key :user_location, String
		
end

