require_relative 'spec_helper'

RSpec.describe Classroom do
  let(:classroom) { Classroom.new('Biology') }
  let(:student) { Student.new(23, 'Andy') }

  describe '#initialize' do
    it 'creates a new Classroom instance' do
      expect(classroom).to be_an_instance_of(Classroom)
    end

    it 'initializes the label' do
      expect(classroom.label).to eq('Biology')
    end

    it 'initializes an empty students array by default' do
      expect(classroom.students).to be_empty
    end

    it 'allows specifying students during initialization' do
      classroom_with_students = Classroom.new('Math', students: [student])
      expect(classroom_with_students.students).to include(student)
    end
  end

  describe '#add_student' do
    it 'adds a student to the classroom' do
      classroom.add_student(student)
      expect(classroom.students).to include(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end
