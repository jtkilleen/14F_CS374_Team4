Feature: Logout

	Scenario: User logs out
		Given a user is logged into the system
		When they log out
		Then they should no longer be logged in