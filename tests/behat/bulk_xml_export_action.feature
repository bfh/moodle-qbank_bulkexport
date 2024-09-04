@qbank @qbank_bulkxmlexport
Feature: Use the qbank plugin manager page for viewquestiontext
  In order to check the plugin behaviour with enable and disable

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "question categories" exist:
      | contextlevel | reference | questioncategory | name     |
      | Course       | C1        | Test Q1          | Test Q1  |
      | Course       | C1        | Test Q1          | Sub Q1.2 |
    And the following "questions" exist:
      | questioncategory | qtype     | name            | questiontext                  |
      | Test Q1          | truefalse | First question  | Answer the first question     |
      | Sub Q1.2         | essay     | Essay Foo Bar   | Write about whatever you want |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage

  @javascript
  Scenario: Enable/disable viewquestiontext column from the base view
    Given I log in as "admin"
    And I navigate to "Plugins > Question bank plugins > Manage question bank plugins" in site administration
    And I should see "View question text"
    When I click on "Disable" "link" in the "View question text" "table_row"
    And I am on the "Test quiz" "quiz activity" page
    And I navigate to "Question bank" in current page administration
    And I should not see "Show question text in the question list"
    Then "#categoryquestions .questiontext" "css_element" should not be visible
    And I navigate to "Plugins > Question bank plugins > Manage question bank plugins" in site administration
    And I click on "Enable" "link" in the "View question text" "table_row"
    And I am on the "Test quiz" "quiz activity" page
    And I navigate to "Question bank" in current page administration
    And I should see "Show question text in the question list"
    And I click on "qbshowtext" "checkbox"
    And I should see "Answer the first question"
