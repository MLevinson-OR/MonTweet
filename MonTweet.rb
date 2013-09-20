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
username =  'Mongo_Username'
password =  'Mongo_Password'

search_or_stream = ARGV[1] || 'METHOD' # 0 : Twitter.search, 1 : Tweetstream Daemon

term = '#nowplaying'

MongoMapper.connection = Mongo::Connection.new(host, port)
MongoMapper.database = 'admin'
MongoMapper.database.authenticate(username,password)
MongoMapper.database = 'nowplaying'
Tweet.ensure_index(:twitter_id, :unique => true)

auth = YAML.load_file File.dirname(__FILE__) + '/twitauth.yml'

def_method(search_or_stream, auth, term)

