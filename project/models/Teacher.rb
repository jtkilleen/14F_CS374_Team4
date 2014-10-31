class Teacher
	include Mongoid::Document

	field :acuid, type: String
	field :firstName, type: String
	field :lastName, type: String
	field :department, type: String

	has_and_belongs_to_many :sections
end