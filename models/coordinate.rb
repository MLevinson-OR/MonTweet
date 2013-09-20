class Coordinate
	include MongoMapper::Document
	
	key :type, String
	key :coordinates, Array
	key :tweet_id, ObjectId
	
	belongs_to :tweet

	def self.new_from_raw(coordinate, tweet_id)
		return if coordinate.nil?	
		coordinate 	= Hashie::Mash[coordinate]
		obj 		= self.new
		obj.type 	= coordinate["type"]
		obj.coordinates = coordinate["coordinates"]
		obj.tweet_id 	= tweet_id
		obj.save!
		obj
	end
end
