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
username =  'mongodb_username'
password =  'mongodb_password'

search_or_stream = ARGV[1] || 'METHOD' # 0 : Twitter.search, 1 : Tweetstream Daemon

term = 'New Orleans Saints' # term(s) to track

MongoMapper.connection = Mongo::Connection.new(host, port)
MongoMapper.database = 'admin'
MongoMapper.database.authenticate(username,password)
MongoMapper.database = 'montweet3'
Tweet.ensure_index(:tweet_id, :unique => true)

auth = YAML.load_file File.dirname(__FILE__) + '/twitauth.yml'

def_method(search_or_stream, auth, term)

