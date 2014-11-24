require_relative '../../classSearch.rb'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

Given(/^I am on the "(.*?)" building page$/) do |building|
	@building = building
end

When(/^I move a class with crn "(.*?)" to room "(.*?)" and time "(.*?)"$/) do |crn, room, time|
	classSearch(crn, room, time)
end

Then(/^it should say "(.*?)"$/) do |output|
	result = if @canMove then "class can move" else "there is a class already at this time" end
	result.should == output
end