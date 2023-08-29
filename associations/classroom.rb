require_relative '../student'

class Classroom
    attr_accessor :label, :students
    
    def initialize(label, students: [])
        @label = label
        @students = students
    end

    def add_student(student)
        @student << student
        student.classroom = self
    end
end


classroom = Classroom.new("Math Room")
student2 = Student.new("Alice", 17)
student2.classroom = classroom  

puts student2.classroom.label
