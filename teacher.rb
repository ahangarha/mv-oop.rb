require './person'

class Teacher < Person
  def initialize(specialization, age, name = 'Unknown')
    super(age, name, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_hash
    {
      class: 'Teacher',
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      specialization: @specialization
    }
  end
end
