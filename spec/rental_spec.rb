require './rental'
require './student'
require './book'
require './person'

describe Rental do
  context 'initialization' do
    it 'gets initialized with right data' do
      student = Student.new(nil, 14, 'Ali')
      book = Book.new('Book Title', 'The Author')
      date = '2015-12-05'

      rental = Rental.new(date, student, book)

      expect(rental.date).to eq date
      expect(rental.person).to be_kind_of(Person)
      expect(rental.book).to be_kind_of(Book)
    end
  end
end
