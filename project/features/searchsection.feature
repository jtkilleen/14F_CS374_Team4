Feature: Search Section

	Scenario: Type in Correct CRN
		Given I type in CRN "1"
		When I look up the class
		Then the section result should be "class found"

	Scenario: Type in Incorrect CRN
		Given I type in CRN "6000"
		When I look up the class
		Then the section result should be "no class found"