Feature: Login and Class Search Integration
	
	Scenario: Search for Classes While Logged In
		Given a user is logged in
		And they search for a section with crn "1"
		When they search for the class
		Then they should see "class found"
