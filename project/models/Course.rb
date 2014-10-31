class Course
	include Mongoid::Document

	field :name, type: String
	field :department, type: String
	field :occurrence, type: String

	has_and_belongs_to_many :sections
	has_many :courses
	belongs_to :courses
end