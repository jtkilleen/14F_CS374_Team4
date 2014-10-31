Feature: System Test

	Scenario: User logs in searchs and moves class
		Given a user logs in
		And the user moves a class to a new time
		And the user searches for the class 
		Then the user should see "class moved"
		And the user logs out
		Then the user should