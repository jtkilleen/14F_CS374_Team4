Feature: Login and Move Section

	Integration Testing

	This feature will deal with the features login and move section integrated together.

	Scenario: Incorrect Login
		Given the username "jeff@jeff.com"
		And the password "killeen"
		When the user logs in
		Then the user should see "login failure"

	Scenario: Correct Login and Move Section to Occupied Room
		Given the username "jeff@jeff.com"
		And the password "jeff"
		When the user logs in
		Then the user should see "login success"

	Scenario: Move section
		Given I need to move section with crn 1 to MBB 316
		And there is a class already in session
		When I move the class
		Then it should say "the room is already occupied"

	Scenario: Correct Login and Move Section to Eligible Room
		Given the username "jeff"
		And the password "jeff"
		When the user logs in
		Then the user should see "login success"
		Given I need to move section with crn 1 to MBB 314
		When I move the class
		Then it should say "successfully moved class"