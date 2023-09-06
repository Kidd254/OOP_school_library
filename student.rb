require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, name = 'unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def join_classroom(classroom)
    @classroom = classroom
    classroom.add_student(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def to_hash
    {
      'age' => @age,
      'classroom' => @classroom,
      'name' => @name,
      'parent_permission' => @parent_permission,
      'role' => 'student'
    }
  end

  def self.from_hash(data)
    age = data['age']
    classroom = data['classroom']
    name = data['name']
    parent_permission = data['parent_permission']
    Student.new(age, classroom, name, parent_permission: parent_permission)
  end
end
