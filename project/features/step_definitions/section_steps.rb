require_relative '../../classSearch.rb'

Given(/^I type in CRN "([^"]*)"$/) do |input|
	@crn = input
end

When(/^I look up the class$/) do
	@result = classSearch(@crn)
end

Then(/^the section result should be "([^"]*)"$/) do |output|
	success = if @result then "class found" else "no class found" end
	success.should == output
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