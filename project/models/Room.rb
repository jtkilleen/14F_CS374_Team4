class Room
	include Mongoid::Document

	field :building, type: String
	field :roomnumber, type: String
	field :occupancy, type: String

	has_many :sections
end