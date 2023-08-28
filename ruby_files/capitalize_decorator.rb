require_relative 'base_decorator'

class Capitalize < Decorator
  def correct_name
    original_name = @nameable.correct_name
    original_name.capitalize
  end
end
