require_relative 'decorator'

class Trimmer < Decorator
  def correct_name
    original_name = @nameable.correct_name
    original_name[0, 4]
  end
end

person = Person.new(22, 'maximilianus')
trimmed_person = Trimmer.new(person)
puts trimmed_person.correct_name
