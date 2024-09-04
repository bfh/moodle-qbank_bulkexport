@qbank @qbank_bulkxmlexport
Feature: Use the plugin to export several question at once in the qbank manager.

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
    And the following "question categories" exist:
      | contextlevel | reference | questioncategory | name     |
      | Course       | C1        | Test Q1          | Test Q1  |
      | Course       | C1        | Test Q1          | Sub Q1.2 |
    And the following "questions" exist:
      | questioncategory | qtype     | name           | questiontext                  |
      | Test Q1          | truefalse | First question | Answer the first question     |
      | Sub Q1.2         | essay     | Essay Foo Bar  | Write about whatever you want |

  @javascript
  Scenario: Export questions as Moodle XML
    When I am on the "Course 1" "core_question > course question bank" page logged in as "teacher1"
    And I should see "First question"
    And I should not see "Essay Foo Bar"
    And I click on "Also show questions from subcategories" "checkbox"
    And I click the "Apply filters" "button"
    And I should see "First question"
    And I should see "Essay Foo Bar"
    And I click on "First question" "checkbox"
    And I click on "Essay Foo Bar" "checkbox"
    And I click on question bulk action "bulkxmlexport"
    Then following "Download" should download between "1" and "180000" bytes