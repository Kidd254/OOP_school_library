require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, name = 'unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def join_classroom(classroom)
    @classroom = classroom
    classroom.add_student(self)  # 
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
student = Student.new(17, 'Class A')

# Output attributes using getters
puts "Student ID: #{student.id}"
puts "Student Age: #{student.age}"
puts "Student Classroom: #{student.classroom}"
puts "Student playing hooky: #{student.play_hooky}"
