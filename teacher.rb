require_relative 'person'
class Teacher < Person
    initialize(id, name = 'unknown', age, parent_permission= true, specialization)
    super(id, name, age, parent_permission,)
    @specialization = specialization
end

def can_use_services?
    @parent_permission
  end
end