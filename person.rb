require_relative 'ruby_files/nameable'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id

  def initialize(age, name, parent_permission: true, rentals: [])
    super()
    @id = rand(1...1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = rentals
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(rental)
    @rentals << rental
  end

  private

  def of_age?
    @age >= 18
  end
end

person = Person.new(25, 'Alice')
puts "Person ID: #{person.id}" # random id
puts "Person Name: #{person.name}" # Alice
puts "Person Age: #{person.age}" # 25
