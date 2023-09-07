require_relative '../student'
require_relative '../person' # Adjust the path as needed

RSpec.describe Student do
  # Define a classroom instance variable for testing
  let(:classroom) { double('Classroom') }

  context 'attributes' do
    let(:student) { Student.new(16, classroom, 'Alice', parent_permission: true) }

    it 'has a name' do
      expect(student.name).to eq('Alice')
    end

    it 'has an age' do
      expect(student.age).to eq(16)
    end

    it 'has a classroom' do
      expect(student.classroom).to eq(classroom)
    end
  end

  context '#join_classroom' do
    let(:student) { Student.new(16, nil, 'Bob', parent_permission: true) }

    it 'adds the student to the classroom' do
      expect(classroom).to receive(:add_student).with(student)
      student.join_classroom(classroom)
    end
  end

  context '#play_hooky' do
    let(:student) { Student.new(16, nil, 'Charlie', parent_permission: true) }

    it 'returns a playful message' do
      expect(student.play_hooky).to eq('¯(ツ)/¯')
    end
  end

  context '#to_hash' do
    let(:student) { Student.new(16, classroom, 'David', parent_permission: true) }

    it 'returns a hash representation of the student' do
      expected_hash = {
        'age' => 16,
        'classroom' => classroom,
        'name' => 'David',
        'parent_permission' => true,
        'role' => 'student'
      }
      expect(student.to_hash).to eq(expected_hash)
    end
  end

  context '.from_hash' do
    let(:data) do
      {
        'age' => 17,
        'classroom' => classroom,
        'name' => 'Eve',
        'parent_permission' => false
      }
    end

    it 'creates a student object from a hash' do
      student = Student.from_hash(data)
      expect(student).to be_a(Student)
      expect(student.age).to eq(17)
      expect(student.classroom).to eq(classroom)
      expect(student.name).to eq('Eve')
      expect(student.parent_permission).to be false
    end
  end
end
