require 'mongoid'
require './models/Section.rb'
require './models/Room.rb'
require './models/Student.rb'

def moveClass(section, room, time)
	### Check
	canMove = true
	if room.nil?
		return "the room does not exist"
	end
	room.sections.each do |s|
		hour = s.hours.split("-")[0]
		puts "THIS IS THE HOUR #{hour}"
		puts "THIS IS THE TIME #{time}"
		if hour == time
			canMove = false
			return "the room is already occupied"
		end
	end
	puts "#{canMove}"
	if canMove
		section.hours = time
		room.sections << section
		section.room = room
	end
	return "successfully moved class"
end
