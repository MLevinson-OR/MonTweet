require_relative 'tweet'

class User
	include MongoMapper::Document

	key :twitter_id, Integer, :required => true
	key :twitter_id_str, String
	key :name, String
	key :screen_name, String, :required => true
	key :location, String
	key :url, String
	key :description, String
	key :protected, Boolean, :default => false
	key :followers_count, Integer, :default => 0
	key :friends_count, Integer, :default => 0
	key :listed_count, Integer, :default => 0
	key :created_at, Time, :required => true
	key :favourites_count, Integer
	key :utc_offset, Integer
	key :time_zone, String
	key :geo_enabled, Boolean, :default => false
	key :verified, Boolean, :default => false
	key :statuses_count, Integer, :default => 0
	key :lang, String
	key :contributors_enabled, Boolean, :default => false
	key :is_translator, Boolean, :default => false
	key :profile_background_color, String, :default => "C0DEED"
	key :profile_background_image_url, String
	key :profile_background_image_url_https, String
	key :profile_background_tile, Boolean, :default => false
	key :profile_image_url, String
	key :profile_image_url_https, String
	key :profile_link_color, String, :default => "0084B4"
	key :profile_sidebar_border_color, String, :default => "C0DEED"
	key :profile_sidebar_fill_color, String, :default => "DDEEF6"
	key :profile_text_color, String, :default => "333333"
	key :profile_use_background_image, Boolean, :default => true
	key :default_profile, Boolean, :default => false
	key :default_profile_image, Boolean, :default => false
	key :following, Boolean, :default => false
	key :follow_request_sent, Boolean, :default => false
	key :notifications, Boolean, :default => false
	key :tweet_ids, Array
	
	many :tweets, :in => :tweet_ids

  	def self.new_from_raw(status)
	    status = Hashie::Mash[Hashie::Clash[status]]
	    obj = self.new
	    obj.twitter_id = status["user"].nil? ? status["id"] : status["user"]["id"]
	    obj.twitter_id_str = status["user"].nil? ? status["id_str"] : status["user"]["id_str"]
	    obj.name = status["user"].nil? ? status["name"] : status["user"]["name"]
	    obj.screen_name = status["user"].nil? ? status["screen_name"] : status["user"]["screen_name"]
	    obj.location = status["user"].nil? ? status["location"] : status["user"]["location"]
	    obj.url = status["user"].nil? ? status["url"] : status["user"]["url"]
	    obj.description = status["user"].nil? ? status["description"] : status["user"]["description"]
	    obj.protected = status["user"].nil? ? status["protected"] : status["user"]["protected"]
	    obj.followers_count = status["user"].nil? ? status["followers_count"] : status["user"]["followers_count"]
	    obj.friends_count = status["user"].nil? ? status["friends_count"] : status["user"]["friends_count"]
	    obj.listed_count = status["user"].nil? ? status["listed_count"] : status["user"]["listed_count"]
	    obj.created_at = status["user"].nil? ? status["created_at"] : status["user"]["created_at"]
	    obj.favourites_count = status["user"].nil? ? status["favourites_count"] : status["user"]["favourites_count"]
	    obj.utc_offset = status["user"].nil? ? status["utc_offset"] : status["user"]["utc_offset"]
	    obj.time_zone = status["user"].nil? ? status["time_zone"] : status["user"]["time_zone"]
	    obj.geo_enabled = status["user"].nil? ? status["geo_enabled"] : status["user"]["geo_enabled"]
	    obj.verified = status["user"].nil? ? status["verified"] : status["user"]["verified"]
	    obj.statuses_count = status["user"].nil? ? status["statuses_count"] : status["user"]["statuses_count"]
	    obj.lang = status["user"].nil? ? status["lang"] : status["user"]["lang"]
	    obj.contributors_enabled = status["user"].nil? ? status["contributors_enabled"] : status["user"]["contributors_enabled"]
	    obj.is_translator = status["user"].nil? ? status["is_translator"] : status["user"]["is_translator"]
	    obj.profile_background_color = status["user"].nil? ? status["profile_background_color"] : status["user"]["profile_background_color"]
	    obj.profile_background_image_url = status["user"].nil? ? status["profile_background_image_url"] : status["user"]["profile_background_image_url"]
	    obj.profile_background_image_url_https = status["user"].nil? ? status["profile_background_image_url_https"] : status["user"]["profile_background_image_url_https"]
	    obj.profile_background_tile = status["user"].nil? ? status["profile_background_tile"] : status["user"]["profile_background_tile"]
	    obj.profile_image_url = status["user"].nil? ? status["profile_image_url"] : status["user"]["profile_image_url"]
	    obj.profile_image_url_https = status["user"].nil? ? status["profile_image_url_https"] : status["user"]["profile_image_url_https"]
	    obj.profile_link_color = status["user"].nil? ? status["profile_link_color"] : status["user"]["profile_link_color"]
	    obj.profile_sidebar_border_color = status["user"].nil? ? status["profile_sidebar_border_color"] : status["user"]["profile_sidebar_border_color"]
	    obj.profile_sidebar_fill_color = status["user"].nil? ? status["profile_sidebar_fill_color"] : status["user"]["profile_sidebar_fill_color"]
	    obj.profile_text_color = status["user"].nil? ? status["profile_text_color"] : status["user"]["profile_text_color"]
	    obj.profile_use_background_image = status["user"].nil? ? status["profile_use_background_image"] : status["user"]["profile_use_background_image"]
	    obj.default_profile = status["user"].nil? ? status["default_profile"] : status["user"]["default_profile"]
	    obj.default_profile_image = status["user"].nil? ? status["default_profile_image"] : status["user"]["default_profile_image"]
	    obj.following = status["user"].nil? ? status["following"] : status["user"]["following"]
	    obj.follow_request_sent = status["user"].nil? ? status["follow_request_sent"] : status["user"]["follow_request_sent"]
	    obj.notifications = status["user"].nil? ? status["notifications"] : status["user"]["notifications"]
	    if status["text"]
	      tweet = Tweet.new_from_raw(status, obj._id)
	      obj.tweets << tweet
	    end
	    if status["status"]
	      tweet = Tweet.new_from_raw(status["status"], obj._id)
	      obj.tweets << tweet
	    end
	    if status["statuses"]
	      status["statuses"].each do |status|
		tweet = Tweet.new_from_raw(status, obj._id)
		obj.tweets << tweet
	      end
	    end
	    obj.save!
	    obj
	  end
end

