require 'rspec'
require 'logger'
require 'timeout'

class Grader

  def initialize
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO
  end

  def grade(submission, spec)
    errs = StringIO.new('', 'w')
    output = StringIO.new('', 'w')
    subprocess_response = -1
    @logger.debug('Start fork')
    begin
      read, write = IO.pipe
      @pid = fork do
        read.close
        # RSpec.configure do |config|
        #   config.formatter = 'documentation'
        #   config.formatter = 'RSpec::Core::Formatters::JsonFormatter'
        # end
        # concerned that requires are maintained across RSpec runs
        result = RSpec::Core::Runner.run(['-r', submission, spec], output, errs)
        write.puts result
        write.close
        # formatter = RSpec.configuration.formatters.select {|formatter| formatter.is_a? RSpec::Core::Formatters::JsonFormatter}.first
        # formatter.output_hash[:examples].first[:status] == failed
      # require 'byebug' ; byebug
      end

      Timeout.timeout(nil) do
        Process.wait @pid
        # 
        # result = $?.exitstatus
      end
      write.close
      subprocess_response = read.gets.chomp
      read.close

    rescue Timeout::Error
      @logger.debug('Subprocess timed out killed and submission received 0 pts.')
      Process.kill 9, @pid # dunno what signal to put for this
      Process.detach @pid  # express disinterest in process so that OS hopefully takes care of zombie
    end
    # puts output.string
    # puts errs.string
    subprocess_response.to_i
  end
end