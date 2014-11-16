class Course
	include Mongoid::Document

	field :name, type: String
	field :department, type: String
	field :occurrence, type: String  #### THE OCCURRENCE ISN'T LISTED IN THE CSV

	has_and_belongs_to_many :sections
	has_many :courses #### DOING PREREQUISITES WON'T MATTER
	belongs_to :courses ### SAME AS ABOVE
end