require './lib/include'

def def_method(sel, auth, term)

	if (sel == 'search')
		Twitter.configure do |config|
			config.consumer_key = auth['consumer_key']
			config.consumer_secret = auth['consumer_secret']
			config.oauth_token = auth['access_token']
		      	config.oauth_token_secret = auth['access_token_secret']
		end
		Twitter.search(term, :count => 100, :result_type => "recent").results.map do |tweet|	
			mon_tweet_store(tweet)	
		end
	else
		TweetStream.configure do |config|
			config.consumer_key 		= auth['consumer_key']
			config.consumer_secret 		= auth['consumer_secret']
			config.oauth_token 		= auth['access_token']
		      	config.oauth_token_secret 	= auth['access_token_secret']
			config.auth_method		= :oauth
		end
		TweetStream::Daemon.new('tracking').on_limit{ |skip_count| }.track(term) do |tweet|
			mon_tweet_store(tweet)
		end
	end
end
