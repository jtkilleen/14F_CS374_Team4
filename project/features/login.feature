Feature: Login

	Scenario:  Type in Correct Username and Password
		Given the username "jeff@jeff.com"
		And the password "jeff"
		When the user logs in
		Then the user should see "login success"

	Scenario: Type in Incorrect Password
		Given the username "jeff@jeff.com"
		And the password "killeen"
		When the user logs in
		Then the user should see "login failure"

	Scenario: Type in Incorrect Username
		Given the username "jon"
		And the username does not exist
		When the user logs in
		Then the user should see "login failure"

			