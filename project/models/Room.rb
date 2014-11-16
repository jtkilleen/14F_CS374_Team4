class Room
	include Mongoid::Document

	field :building, type: String
	field :roomnumber, type: String
	field :occupancy, type: String  #### The attributes for room do not exist in the CSV, not using currently

	has_many :sections
end