require_relative 'person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(age, name = 'unknown', parent_permission: true, specialization: nil)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_hash
    {
      'age' => @age,
      'name' => @name,
      'specialization' => @specialization,
      'role' => 'teacher' 
    }
  end

  def self.from_hash(data)
    age = data['age']
    name = data['name']
    specialization = data['specialization']
    Teacher.new(age, name, specialization: specialization)
  end
end
