Feature: Search Section

	Scenario: Type in Correct CRN
		Given I type in CRN 1
		When I look up the class
		Then I should see "class found"

	Scenario: Type in Incorrect CRN
		Given I type in CRN 6000
		When I look up the class
		Then I should see "no class found"