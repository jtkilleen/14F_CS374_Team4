Feature: Conflicts

	Scenario: Move Section with Conflicts in Student Schedule
		Given I am on the "MBB" building page
		When I move a class with crn "10730" to room "118" and time "8:00-8:50"
		Then it should say "class can move"
		And it should state that "There are conflicts"
		And a student with crn "000515364" should "have a conflict"

	Scenario: Move Section without Conflicts in Student Schedule
		Given I am on the "MBB" building page
		When I move a class with crn "10733" to room "118" and time "8:00-8:50"
		Then it should say "class can move"
		And it should state that "There are no conflicts"
		And a student with crn "000832114" should "not have a conflict"