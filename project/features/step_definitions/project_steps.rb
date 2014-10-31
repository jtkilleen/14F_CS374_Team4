Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
Given(/^the username "([^"]*)"$/) do |inputs|
	@username = input
end

Given(/^I need to move a section with crn "([^"]*)"$/) do |input|
	@section = input
end

Given(/^that section with crn "([^"]*)"$/) do |input|
	@section = input
end

And(/^the password "([^"]*)"$/) do |input|
	@password = input
end

When(/^the user logs in$/) do
	@loginOutput = loginUser(@username, @password)
end

Then(/^the user should see "([^"]*)"$/) do |output|
	@loginOutput.should == output
end