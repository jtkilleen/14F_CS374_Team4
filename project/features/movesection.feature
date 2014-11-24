Feature: Move Section

	This feature will deal with tests that allow the user
	to interact with moving sections in the class scheduler

	Scenario: Move Section and Get No Conflicts
		Given I am on the "MBB" schedule
		When I click on room "118" and time "8:00-8:50" and crn "11033"
		Then I should see "There are no conflicts"