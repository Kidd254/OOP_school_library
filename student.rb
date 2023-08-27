require_relative 'person'

class Student < Person
    def initialize(id, name = 'unknown', age, parent_permission= true, classroom)
        super(id, name, age, parent_permission)
        @classroom = classroom
    end

    def play_hooky
        "¯\(ツ)/¯"
    end
end
