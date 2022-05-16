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

  def correct_name
    @name
  end

  def add_rental(date, book)
    Rental.new(date, self, book)
  end
end
