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
  it 'converts to a hash' do
    person = Person.new(25, 'Alice', parent_permission: true)
    expected_hash = {
      'age' => 25,
      'name' => 'Alice',
      'parent_permission' => true
    }
    expect(person.to_hash).to eq(expected_hash)
  end

  # Test the 'correct_name' method
  it 'returns the correct name' do
    person = Person.new(30, 'Bob', parent_permission: false)
    expect(person.correct_name).to eq('Bob')
  end
end

context 'usage permissions' do
  # Test the 'self.from_hash' method
  it 'creates a Person object from a hash' do
    data = {
      'age' => 18,
      'name' => 'Eve',
      'parent_permission' => true
    }
    person = Person.from_hash(data)
    expect(person).to be_a(Person)
    expect(person.age).to eq(18)
    expect(person.name).to eq('Eve')
    expect(person.parent_permission).to be true
  end
end
