Feature: Conflicts

	Scenario: Move Section without Conflicts in Student Schedule
		Given that section with crn 1 needs to be moved
		When I move the class to 1:30
		Then there should be no conflicts in any student's schedule

	Scenario: Move Section with Conflicts in Student Schedule
		Given that section with crn 1 needs to be moved
		When I move the class to 8:00
		Then there should be a conflict with the student jeff

	Scenario: Move Section that conflicts with Senior's Schedule
		Given that section with crn 1 needs to be moved
		And jon is taking crn 1
		And jon is a Senior
		When I move the class to 9:30
		Then the class should not be moved

