require_relative '../../login.rb'
######################## Connecting to Database ###########################
Given(/^the username "([^"]*)"$/) do |input|
	@username = input
end

Given(/^I need to move a section with crn "([^"]*)"$/) do |input|
	@section = input
end

Given(/^that section with crn "([^"]*)"$/) do |input|
	@section = input
end

Given(/^a user is logged into the system$/) do
	# Here I am spoofing a sesssion
	@email = "jeff@jeff.com"
	@password = "jeff"
	loginUser(@email, @password).should == true
end

And(/^the username does not exist$/) do
	findUser(@username).should == nil
end

And(/^the password "([^"]*)"$/) do |input|
	@password = input
end

When(/^the user logs in$/) do
	@loginOutput = loginUser(@username, @password)
end

When(/^they log out$/) do
	@email = ""
	@password = ""
end

Then(/^the user should see "([^"]*)"$/) do |output|
	success = if @loginOutput then "login success" else "login failure" end
	success.should == output
end

Then(/^they should no longer be logged in$/) do
	# When the user is logged in, they have their email saved in their session
	# Once they logout, their session email should be set to ""
	# This causes user to not exist in the database and thus must be logged out
	user = User.where(username: @email).first
	user.should == nil
end
############################ Connecting to Website ########################
Given(/^I am on the "(.*?)" page$/) do |input|
	visit "/#{input}"
end

When(/^I login with "(.*?)" username and "(.*?)" password$/) do |user, password|
    fill_in 'exampleInputEmail1', :with => user
    fill_in 'exampleInputPassword1', :with => password
    click_button 'Submit'
end

Then(/^I should connect to the "(.*?)" page$/) do |output|
	if output == "home"
		expect(page).to have_content 'Home'
	else
		expect(page).to have_content output
	end
end