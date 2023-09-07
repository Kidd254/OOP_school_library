require_relative 'spec_helper'
require 'rspec'

RSpec.describe Nameable do
  describe '#correct_name' do
    context 'when correct_name is called' do
      it 'raises NotImplementedError' do
        nameable_instance = Nameable.new

        expect do
          nameable_instance.correct_name
        end.to raise_error(NotImplementedError, 'Subclasses must implement this method')
      end
    end
  end
end
