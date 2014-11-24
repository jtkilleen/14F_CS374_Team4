require 'csv'
require_relative '../../populate.rb'

Given(/^I am on the "(.*?)" schedule$/) do |input|
	puts "/building/#{input}"
	visit "/building/#{input}"
end

When(/^I click on room "(.*?)" and time "(.*?)" and crn "(.*?)"$/) do |room, time, crn|
	expect(page).to have_content room
	# within(fields) do
	# 	find('div.tblCell', text: "#{room}").click
	# 	find('div.tblCell', text: "#{time}").click
	# 	find('div.tblCell', text: "#{crn}").click
	# end
end

Then(/^I should see "(.*?)"$/) do |output|
	expect(page).to have_content output
end