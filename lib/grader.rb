require 'rspec'

class Grader
  def grade(submission, spec)
    errs = StringIO.new('', 'w')
    output = StringIO.new('', 'w')
    # concerned that requires are maintained across RSpec runs
    result = RSpec::Core::Runner.run(['-r', submission, spec], errs, output)
    # puts output.string
    # puts errs.string
    result
  end
end