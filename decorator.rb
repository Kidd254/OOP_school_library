require_relative 'nameable'

class Decorator < Nameable
    def initialize(nameable)
        @nameable = nameable
    end

    def correct_name
        original_name = @nameable.correct_name
        capitalized_name = original_name.capitalize
        capitalized_name
    end
end

require_relative 'person'

person3 = Person.new(27, 'eunice')
decorated_person = Decorator.new(person3)
puts decorated_person.correct_name   #Eunice