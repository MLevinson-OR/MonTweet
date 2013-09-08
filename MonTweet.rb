#!/usr/bin/env ruby

=begin
twitauth.yml should contain
	consumer_key: your_consumer_key
	consumer_secret: your_consumer_secret
	access_token: your_access_token
	access_token_secret: your_access_token_secret
=end

require './lib/include'

host=  'localhost'
port =  27017
username =  'MongoDb_username'
password =  'MongoDb_password'

num  = 3 # number of loops ( total tweet count = (num + 1) * 100)
term = 'Machine Learning'

auth = YAML.load_file File.dirname(__FILE__) + '/twitauth.yml'

Twitter.configure do |config|
	config.consumer_key = auth['consumer_key']
	config.consumer_secret = auth['consumer_secret']
	config.oauth_token = auth['access_token']
      	config.oauth_token_secret = auth['access_token_secret']
end

MongoMapper.connection = Mongo::Connection.new(host, port)
MongoMapper.database = 'montweet'
MongoMapper.database.authenticate(username,password)

puts "Preparing to search for #{term}" 


	Twitter.search(term, :count => 100, :result_type => "recent").results.map do |tweet|	
		mon_tweet_store(tweet)	
	end



