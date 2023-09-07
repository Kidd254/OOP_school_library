require_relative 'spec_helper.rb'

RSpec.describe Decorator do
  let(:nameable) { double('Nameable') }
  let(:decorator) { Decorator.new(nameable) }

  describe '#initialize' do
    it 'creates a new Decorator instance' do
      expect(decorator).to be_an_instance_of(Decorator)
    end

    it 'initializes the nameable instance variable' do
      expect(decorator.instance_variable_get(:@nameable)).to eq(nameable)
    end
  end

  describe '#correct_name' do
    it 'delegates the correct_name method to the nameable object' do
      expect(nameable).to receive(:correct_name).and_return('Andy')
      expect(decorator.correct_name).to eq('Andy')
    end
  end
end
