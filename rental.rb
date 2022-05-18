class Rental
  attr_reader :person, :book
  attr_accessor :date

  def initialize(date, person, book)
    @date = date
    @person = person
    person.rentals << self
    @book = book
    book.rentals << self
  end

  def to_hash
    {
      person_id: @person.id,
      book_id: @book.id,
      date: @date
    }
  end
end
