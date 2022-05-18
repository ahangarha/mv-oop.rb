require './nameable'
require 'securerandom'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :rentals

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = SecureRandom.uuid
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    super()
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    Rental.new(date, self, book)
  end

  def to_hash
    {
      class: 'Person',
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission
    }
  end

  private

  def of_age?
    @age >= 18
  end
end
