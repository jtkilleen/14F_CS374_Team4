require_relative '../../classSearch.rb'
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

Given(/^I am on the "(.*?)" building page$/) do |building|
	@building = building
end

Given(/^I have a section with crn "(.*?)"$/) do |crn|
	@crn = crn
end

When(/^I move a class with crn "(.*?)" to room "(.*?)" and time "(.*?)"$/) do |crn, room, time|
	classSearch(crn, room, time)
end

When(/^I look up the class$/) do
	@class = Section.where(crn: @crn).first
end

Then(/^it should say "(.*?)"$/) do |output|
	result = if @canMove then "class can move" else "cannot move class" end
	result.should == output
end

Then(/^the section result should be "(.*?)"$/) do |output|
	message = if @class.nil? then "no class found" else "class found" end
	message.should == output
end

And(/^it should state that "(.*?)"$/) do |output|
	result = if @conflicts.length == 0 then "There are no conflicts" else "There are conflicts" end
	result.should == output
end

And(/^a student with crn "(.*?)" should "(.*?)"$/) do |student, output|
	exists = false
	theStudent = Student.where(acuid: student).first
	theStudent.nil?.should == false
	@conflicts.each do |c|
		puts c[:banner]
		if c[:banner] == theStudent[:acuid]
			exists = true
		end
	end
	message = if exists then "have a conflict" else "not have a conflict" end
	message.should == output
end