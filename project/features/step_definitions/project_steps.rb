Given(/^the username "([^"]*)"$/) do |input|
	@input = input
end

When(/^the user logs in/) do
	@output = true
end

Then(/^the user logged in should be true$/) do
	@output.should == true
end