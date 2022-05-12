require './person'
require './classroom'

class Student < Person
  attr_reader :classroom

  def initialize(classroom, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    self.classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end

  def classroom=(new_classroom)
    # only set classroom if we get a new_classroom of type Classroom
    return nil unless new_classroom.is_a?(Classroom)
    # remove student from classroom if we get a new classroom
    @classroom.remove_student(self) unless @classroom.nil? || @classroom == new_classroom

    @classroom = new_classroom
    @classroom.add_student(self) unless @classroom.students.include?(self)
  end
end
