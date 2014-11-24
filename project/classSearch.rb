require 'mongoid'
require './models/Section.rb'
require './models/Teacher.rb'
require './models/Course.rb'
require './models/Student.rb'

def classSearch(crn,room,time)
	begin
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

		if @canMove
			students = section.students
			students.each do |s|
				s.sections.each do |sect|
					dayCheck = false
					days.each do |d|
						if sect.day.include? d
							dayCheck = true
						end
					end
					if sect.beginTime == time and sect != section and dayCheck
						conflictExists = false
						@conflicts.each do |c|
							if c[:banner] == s.acuid
								conflictExists = true
							end
						end
						if conflictExists then next end
						@conflicts << Hash[firstName: s.firstName, lastName: s.lastName, banner: s.acuid, classification: s.classification]
					end
				end
			end
		end
		@conflicts.sort_by!{|s| s[:classification]}.reverse!
	rescue
		@canMove = false
	end
end

