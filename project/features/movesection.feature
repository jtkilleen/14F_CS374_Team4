Feature: Move Section

	This feature will deal with tests that allow the user
	to interact with moving sections in the class scheduler

	Scenario: Move Section to Eligible Room
		Given I am on the "MBB" building page
		When I move a class with crn "10048" to room "118" and time "8:00-8:50"
		Then it should say "class can move"
		And it should state that "There are no conflicts"

	Scenario: Move Section to Occupied Room
		Given I am on the "MBB" building page
		When I move a class with crn "10048" to room "117" and time "8:00-8:50"
		Then it should say "cannot move class"

	Scenario: Move Section to Nonexisting Room
		Given I am on the "MBB" building page
		When I move a class with crn "10048" to room "666" and time "8:00-8:50"
		Then it should say "cannot move class"

	Scenario: Section Moved with Conflicts
		Given I am on the "MBB" building page
		When I move a class with crn "10730" to room "118" and time "8:00-8:50"
		Then it should say "class can move"
		And it should state that "There are conflicts"
