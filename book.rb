require './rental'
require 'securerandom'

class Book
  attr_accessor :title, :author
  attr_reader :id, :rentals

  def initialize(title, author, id: nil)
    @id = id.nil? ? SecureRandom.uuid : id
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(date, person)
    Rental.new(date, person, self)
  end

  def to_hash
    {
      class: 'Book',
      id: @id,
      title: @title,
      author: @author
    }
  end
end
