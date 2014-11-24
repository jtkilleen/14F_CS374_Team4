require 'csv'
require_relative '../../populate.rb'

Given(/^I am on the "(.*?)"$/) do |input|
	visit '/building/'+input
end

When(/^I click on room "(.*?)" and time "(.?)" and crn "(.?)"$/) do |room,time,crn|
	find('.tblCell', :text => room).click
	find('.tblCell', :text => time).click
	find('tblCell.crn', :text => crn).click
end

Then(/^I should see "(.?)"$/) do |message|
	expect(page).to have_content message
end