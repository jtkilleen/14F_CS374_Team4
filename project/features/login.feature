Feature: Login

	Scenario Outline:  Type in Correct Username and Password
		Given the username "<username>"
		When the user logs in
		Then the user logged in should be <output>

		Examples:
			| username | output |
			| jkjk	   | true   |
			