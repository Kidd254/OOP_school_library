require_relative 'person'
class Teacher < Person
  attr_accessor :specialization

  def initialize(age, specialization, name = 'unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

# Create a Teacher instance
teacher = Teacher.new(3, 35, 'Mathematics')

# Output attributes using getters
puts "Teacher ID: #{teacher.id}"
puts "Teacher Age: #{teacher.age}"
puts "Teacher Specialization: #{teacher.specialization}"

# Test can_use_services? method
puts "Teacher can use services: #{teacher.can_use_services?}"
