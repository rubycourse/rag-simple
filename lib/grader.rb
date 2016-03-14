require 'rspec'

class Grader
  def grade(submission, spec)
    errs = StringIO.new('', 'w')
    output = StringIO.new('', 'w')
    result = RSpec::Core::Runner.run(['-r', submission, spec], errs, output)
    # puts output.string
    # puts errs.string
    result
  end
end