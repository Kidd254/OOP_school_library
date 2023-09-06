require_relative '../teacher'
require_relative '../person' 


RSpec.describe Teacher do
  context 'attributes' do
    let(:teacher) { Teacher.new(35, 'Alice', specialization: 'Math') }

    it 'has a name' do
      expect(teacher.name).to eq('Alice')
    end

    it 'has an age' do
      expect(teacher.age).to eq(35)
    end

    it 'has a specialization' do
      expect(teacher.specialization).to eq('Math')
    end
  end

  context '#can_use_services?' do
    let(:teacher) { Teacher.new(40, 'Bob', specialization: 'History') }

    it 'can always use services' do
      expect(teacher.can_use_services?).to be true
    end
  end

  context '#to_hash' do
    let(:teacher) { Teacher.new(30, 'Carol', specialization: 'Science') }

    it 'returns a hash representation of the teacher' do
      expected_hash = {
        'age' => 30,
        'name' => 'Carol',
        'specialization' => 'Science',
        'role' => 'teacher'
      }
      expect(teacher.to_hash).to eq(expected_hash)
    end
  end

  context '.from_hash' do
    let(:data) do
      {
        'age' => 45,
        'name' => 'David',
        'specialization' => 'English'
      }
    end

    it 'creates a teacher object from a hash' do
      teacher = Teacher.from_hash(data)
      expect(teacher).to be_a(Teacher)
      expect(teacher.age).to eq(45)
      expect(teacher.name).to eq('David')
      expect(teacher.specialization).to eq('English')
    end
  end
end
