require_relative 'person'
require_relative 'decorator'
require_relative 'trimmer_decorator'

person4 = Person.new(22, 'maximilianus')
decorated_person = Decorator.new(person4) # capitalize the first letter
trimmed_person = Trimmer.new(decorated_person) # trim the name

puts trimmed_person.correct_name
