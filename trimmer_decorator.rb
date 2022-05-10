require './decorator'

class TrimmerDecorator < Decorator
  def correct_name
    @nameable_object.correct_name[0..9]
  end
end
