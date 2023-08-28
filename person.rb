require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'unknown', parent_permission: true)
    @id = rand(1...1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end
end

person = Person.new(25, 'Alice')
puts "Person ID: #{person.id}"     #random id
puts "Person Name: #{person.name}"  # Alice
puts "Person Age: #{person.age}"     # 25

# test correct_name inherited method after override
person2 = Person.new(27, 'Lawrence')
puts person2.correct_name #Lawrence
