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
    if new_classroom.is_a?(Classroom)
      # remove student from classroom if we get a new classroom
      @classroom.remove_student(self) unless @classroom.nil? || @classroom == new_classroom

      @classroom = new_classroom
      @classroom.add_student(self) unless @classroom.students.include?(self)
    else
      @classroom = nil
    end
  end

  def to_hash
    {
      class: 'Student',
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      classroom: @classroom
    }
  end
end
