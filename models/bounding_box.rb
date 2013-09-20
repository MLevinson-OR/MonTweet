class BoundingBox
	include MongoMapper::Document

	key :type, String, :required => true
	key :coordinates, Array, :required => true
	key :place_id, ObjectId

	belongs_to :place

	def self.new_from_raw(bounding_box, place_id)
		return nil if bounding_box.nil?
		bounding_box 	= Hashie::Mash[bounding_box]
		obj 		= self.new
		obj.type 	= bounding_box["type"] || "Not Specified"
		obj.coordinates = bounding_box["coordinates"]
		obj.place_id 	= place_id
		obj.save!
		obj
	end
end
