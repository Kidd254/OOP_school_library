require_relative 'spec_helper'

RSpec.describe Capitalize do
  let(:nameable) { double('Nameable') }
  let(:capitalize_decorator) { Capitalize.new(nameable) }

  describe '#initialize' do
    it 'creates a new Capitalize instance' do
      expect(capitalize_decorator).to be_an_instance_of(Capitalize)
    end
  end

  describe '#correct_name' do
    it 'capitalizes the correct_name method from the nameable object' do
      expect(nameable).to receive(:correct_name).and_return('Andy')
      expect(capitalize_decorator.correct_name).to eq('Andy')
    end

    it 'preserves uppercase letters in the correct_name' do
      expect(nameable).to receive(:correct_name).and_return('ANDY')
      expect(capitalize_decorator.correct_name).to eq('Andy')
    end
  end
end
