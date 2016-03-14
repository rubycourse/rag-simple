Given(/^we have '(.*)' available$/) do |repo|
  @folder = repo.split('/')[1]
  `rm -rf #{@folder}`
  `git clone https://github.com/#{repo}`
end


Given(/^that a student has submitted a correct solution$/) do
  @correct_submission = "./#{@folder}/solutions/lib/part1.rb"
end

Given(/^I have specified a specification$/) do
  @specification = "#{@folder}/autograder/part1_spec.rb"
end

Then(/^they should see correct feedback$/) do
  `rspec -r #{@correct_submission} #{@specification}`
end