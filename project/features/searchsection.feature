Feature: Search Section

	Scenario: Type in Correct CRN
		Given I have a section with crn "11095"
		When I look up the class
		Then the section result should be "class found"

	Scenario: Type in Incorrect CRN
		Given I have a section with crn "-1"
		When I look up the class
		Then the section result should be "no class found"