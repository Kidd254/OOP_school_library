require_relative '../person'
require_relative '../ruby_files/nameable'

RSpec.describe Person do
  describe 'attributes' do
    let(:person) { Person.new(20, 'John', parent_permission: true) }

    it 'has a name' do
      expect(person.name).to eq('John')
    end

    it 'has an age' do
      expect(person.age).to eq(20)
    end

    it 'can add rentals' do
      rental = double('Rental')
      person.add_rental(rental)
      expect(person.rentals).to include(rental)
    end
  end

  context 'usage permissions' do
    let(:person_with_permission) { Person.new(20, 'John', parent_permission: true) }
    let(:person_without_permission) { Person.new(16, 'Sam', parent_permission: false) }

    it 'can use services with parent permission' do
      expect(person_with_permission.can_use_services?).to be true
    end

    it 'can use services when of age' do
      expect(person_without_permission.can_use_services?).to be false
    end

    it 'cannot use services without parent permission or being of age' do
      expect(person_with_permission.can_use_services?).to be true
      expect(person_without_permission.can_use_services?).to be false
    end
  end
end
