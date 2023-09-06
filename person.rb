require_relative 'ruby_files/nameable'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id

  def initialize(age, name = 'unknown', parent_permission: true)
    super()
    @id = rand(1...1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
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

  def to_hash
    {
      'age' => @age,
      'name' => @name,
      'parent_permission' => @parent_permission
    }
  end

  def self.from_hash(data)
    age = data['age']
    name = data['name']
    parent_permission = data['parent_permission']

    # Create a new Person object using the hash data
    Person.new(age, name, parent_permission: parent_permission)
  end

  private

  def of_age?
    @age >= 18
  end
end
