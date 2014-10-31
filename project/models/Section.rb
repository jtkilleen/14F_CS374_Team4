class Section
	include Mongoid::Document

	field :crn, type: String
	field :hours, type: String
	field :day, type: String

	has_and_belongs_to_many :students
	has_and_belongs_to_many :courses
	has_and_belongs_to_many :sections
	belongs_to :room
end