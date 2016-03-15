require 'grader'

Given(/^we have '(.*)' available$/) do |repo|
  @folder = repo.split('/')[1]
  `rm -rf #{@folder}`
  `git clone https://github.com/#{repo}`
end

Given(/^we have reset RSpec$/) do
  RSpec.clear_examples
end

Given(/^that a student has submitted a correct solution$/) do
  @correct_submission = "./#{@folder}/solutions/lib/part1.rb"
end

Given(/^that a student has submitted an incorrect solution$/) do
  @correct_submission = "./#{@folder}/solutions/lib/part2.rb"
end

Given(/^I have specified a specification for '(.*)'$/) do |spec|
  @specification = "#{@folder}/autograder/#{spec}"
end

Then(/^they should see correct feedback$/) do
  expect(Grader.new.grade(@correct_submission, @specification)).to eq 0
end

Then(/^they should see incorrect feedback$/) do
  expect(Grader.new.grade(@correct_submission, @specification)).to eq 1
end