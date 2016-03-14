require 'grader'

describe Grader do
  subject(:grader) { described_class.new }
  let(:correct_submission) { double :submission }
  let(:incorrect_submission) { double :submission }
  let(:spec) { double :spec }

  it 'grades a correct submission against specification as correct' do
    result = grader.grade(correct_submission, spec)
    expect(result).to eq 'correct'
  end

  xit 'grades an incorrect submission against specification as incorrect' do
    result = grader.grade(incorrect_submission, spec)
    expect(result).to eq 'incorrect'
  end
end