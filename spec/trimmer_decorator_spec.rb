require_relative 'spec_helper'

RSpec.describe Trimmer do
  let(:nameable) { double('Nameable') }
  let(:trimmer_decorator) { Trimmer.new(nameable) }

  describe '#initialize' do
    it 'creates a new Trimmer instance' do
      expect(trimmer_decorator).to be_an_instance_of(Trimmer)
    end
  end

  describe '#correct_name' do
    it 'trims the correct_name method from the nameable object' do
      expect(nameable).to receive(:correct_name).and_return('Andres Zamorano')
      expect(trimmer_decorator.correct_name).to eq('Andres Zam')
    end

    it 'handles names shorter than 10 characters' do
      expect(nameable).to receive(:correct_name).and_return('Andres Zamorano')
      expect(trimmer_decorator.correct_name).to eq('Andres Zam')
    end
  end
end
