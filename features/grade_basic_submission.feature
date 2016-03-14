Feature: Grade Basic Submission
  As an instructor
  So that I can save time grading student's submissions
  I would like an automatically generated grade on their work

  Background:
    Given we have 'saasbook/hw-ruby-intro-ci' available

  Scenario: Grade Correct Submission
    Given that a student has submitted a correct solution
    And I have specified a specification for 'part1_spec.rb'
    Then they should see correct feedback

  Scenario: Grade Incorrect Submission
    Given that a student has submitted an incorrect solution
    And I have specified a specification for 'part3_spec.rb'
    Then they should see incorrect feedback