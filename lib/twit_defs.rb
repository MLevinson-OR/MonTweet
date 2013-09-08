require './lib/include'

def mon_tweet_store(tweet)
    if tweet.geo == nil
	tweetdat = Tweet.new({ 	
				:tweet_created_at => tweet.created_at,
			   	:tweet_id => tweet.id,
			 	:tweet_id_str => tweet.id.to_s,				
				:tweet_coordinates => tweet.geo,
				:tweet_text => tweet.text,
				:user_created_at => tweet.user.created_at,
				:user_id => tweet.user.id,
				:user_id_str => tweet.user.id.to_s,
				:user_screen_name => tweet.user.screen_name,
				:user_geo_enabled => tweet.user.geo_enabled,
				:user_location => tweet.user.location
 	})
	tweetdat.save!
    else
	tweetdat = Tweet.new({ 	
				:tweet_created_at => tweet.created_at,
			   	:tweet_id => tweet.id,
			 	:tweet_id_str => tweet.id.to_s,				
				:tweet_coordinates => tweet.geo.coordinates,
				:tweet_text => tweet.text,
				:user_created_at => tweet.user.created_at,
				:user_id => tweet.user.id,
				:user_id_str => tweet.user.id.to_s,
				:user_screen_name => tweet.user.screen_name,
				:user_geo_enabled => tweet.user.geo_enabled,
				:user_location => tweet.user.location
 	})
	tweetdat.save!
    end
end


