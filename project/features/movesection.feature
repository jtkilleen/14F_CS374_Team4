Feature: Move Section

	This feature will deal with tests that allow the user
	to interact with moving sections in the class scheduler

	Scenario: Move Section to Eligible Room
		Given I am on the "MBB" building page
		When I move a class with crn "10048" to room "118" and time "8:00-8:50"
		Then it should say "class can move"

	Scenario: Move Section to Occupied Room
		Given I am on the "MBB" building page
		Given I need to move section with crn "1" to "MBB 316" at "8:00"
		And there is a class already in session
		When I move the class
		Then it should say "the room is already occupied"

	Scenario: Move Section to Nonexisting Room
		Given I am on the "MBB" building page
		Given I need to move section with crn "1" to "MBB 666" at "8:00"
		And the room does not exist
		When I move the class
		Then it should say "the room does not exist"

	Scenario:  Move Section to Unavailable Time
		Given I am on the "MBB" building page
		Given I need to move section with crn "1" to "11:00"
		When I move the class
		Then it should say "classes are not allowed to be moved to this time"