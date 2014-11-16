class Section
	include Mongoid::Document

	field :crn, type: String
	field :beginTime, type: String
	field :endTime, type: String
	field :day, type: String

	has_and_belongs_to_many :students
	has_and_belongs_to_many :courses
	has_and_belongs_to_many :sections
	has_and_belongs_to_many :teachers
	belongs_to :room
end