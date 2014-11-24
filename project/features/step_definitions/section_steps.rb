require_relative '../../classSearch.rb'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

Given(/^I am on the "(.*?)" building page$/) do |building|
	@building = building
end

When(/^I move a class with crn "(.*?)" to room "(.*?)" and time "(.*?)"$/) do |crn, room, time|
	@conflicts = []
	section = Section.where(crn: "#{crn}").first
	#teacher = section.teachers.first
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

Then(/^it should say "(.*?)"$/) do |output|
	result = if @canMove then "class can move" else "there is a class already at this time" end
	result.should == output
end