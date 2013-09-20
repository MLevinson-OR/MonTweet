require './lib/include'

def def_method(sel, auth, term)

	if (sel == 'search')
		@client = Twitter.configure do |config|
			config.consumer_key = auth['consumer_key']
			config.consumer_secret = auth['consumer_secret']
			config.oauth_token = auth['access_token']
			config.oauth_token_secret = auth['access_token_secret']
		end
		@client.search(term, :count => 100, :result_type => "recent").statuses.each do |tweet|
			User.new_from_raw(tweet)
			#puts "#{tweet.text}"
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
			User.new_from_raw(tweet)
		end
	end
end
