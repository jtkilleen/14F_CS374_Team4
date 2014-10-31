Feature: Move Section and Search Section Integration
	
	Scenario: Searching for a Section after Moving Section
		Given a section with crn 1 and location at "MBB 314"
		And the section is moved to "MBB 316"
		When the user searches for the class
		Then the location should be "MBB 316"

	Scenario: Searching for a nSection after Moving Section Non Existant Section
		Given a section with crn "1000" and location at "MBB 666"
		And the section does not exist
		And the section is moved
		When the user searches for the class
		Then the location should be "not found"