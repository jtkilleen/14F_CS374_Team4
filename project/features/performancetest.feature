Feature: Peformance Test
	
	These tests should test the limits of the System

	Scenario: Move Section with Many Students
		Given I need to move section with crn "1" to MBB "316"
		And the section has over "1000" students
		When I move the class
		Then it should say "successfully moved class"

	Scenario: Move Section to Earliest possible timeslot
		Given I need to move section with crn "1"
		When I move the section time to "8:00"
		Then it should say "successfully moved class"

	Scenario: Move Section to Latest possible timeslot
		Given I need to move section with crn "1"
		When I move the section time to "18:00"
		Then it should say "successfully moved class"

	Scenario: Searching for a Section with 1000 different classes
		Given I need search for a class with crn "1"
		And there are over "1000"
		When I search for the class
		Then I should see
