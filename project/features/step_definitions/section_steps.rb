require_relative '../../classSearch.rb'
require_relative '../../moveClass.rb'

Given(/^I type in CRN "([^"]*)"$/) do |input|
	@crn = input
end

Given(/^I need to move section with crn "(.*?)" to "(.*?)" at "(.*?)"$/) do |crn, buildingroom, starttime|
	@section = Section.where(crn: crn).first
	@section.should_not be_nil
	buildarr = buildingroom.split(" ")
	building = buildarr[0]
	roomnumber = buildarr[1]
	@room = Room.where(building: building, roomnumber: roomnumber).first
	@time = starttime
end

And(/^there is a class already in session$/) do
	occClass = ""
	@room.sections.each do |s|
		if s.hours.split("-")[0] == @time
			occClass = s
		end
	end
	occClass.hours.should == @section.hours
end

And(/^the room does not exist$/) do
	@room.nil? == true
end

When(/^I look up the class$/) do
	@result = classSearch(@crn)
end

When(/^I move the class$/) do
	@oldRoom = @section.room
	@oldTime = @section.hours
	@result = moveClass(@section, @room, @time)
end

Then(/^the section result should be "([^"]*)"$/) do |output|
	success = if @result then "class found" else "no class found" end
	success.should == output
end

Then(/^it should say "(.*?)"$/) do |output|
	@result.should == output
end

# And(/^the username does not exist$/) do
# 	findUser(@username).should == nil
# end

# Given(/^I need to move a section with crn "([^"]*)"$/) do |input|
# 	@section = input
# end

# Given(/^that section with crn "([^"]*)"$/) do |input|
# 	@section = input
# end

# And(/^the password "([^"]*)"$/) do |input|
# 	@password = input
# end

# When(/^the user logs in$/) do
# 	@loginOutput = loginUser(@username, @password)
# end

# Then(/^the user should see "([^"]*)"$/) do |output|
# 	success = if @loginOutput then "login success" else "login failure" end
# 	success.should == output
# end