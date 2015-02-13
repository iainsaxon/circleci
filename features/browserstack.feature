Feature: Remote urls via Browserstack

  @mink:browser_stack
  Scenario: Visit Newism and Subscribe
    Given I am on "http://newism.com.au"
    When I fill in "whykr-whykr" with "team@newism.com.au"
    And I press "Subscribe"
    Then I should see "Thank You"
    Then take a screenshot
