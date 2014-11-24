require 'mongoid'
require './models/Section.rb'
require './models/Teacher.rb'
require './models/Course.rb'
require './models/Student.rb'

def classSearch(crn,room,time)
	@conflicts = []
	section = Section.where(crn: crn).first
	teacher = section.teachers.first
	room = Room.where(building: @building, roomnumber: room).first
	time = time.split("-")[0].gsub(':','')
	@canMove = true
	days = section.day.split("")
	room.sections.each do |s|
		dayCheck = false
		days.each do |d|
			if s.day.include? d
				dayCheck = true
			end
		end
		if s.beginTime == time  && dayCheck
			@canMove = false
		end
	end
end

