require_relative 'base_decorator'

class Trimmer < Decorator
  def correct_name
    original_name = @nameable.correct_name
    original_name[0, 10]
  end
end
