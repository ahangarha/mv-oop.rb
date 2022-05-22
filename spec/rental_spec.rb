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

  context 'test to_hash method' do
    it 'generate correct hash of the instance' do
      student = Student.new(nil, 14, 'Ali', id: 'student_id_1')
      book = Book.new('Book Title', 'The Author', id: 'book_id_1')
      date = '2015-12-05'

      rental = Rental.new(date, student, book)
      expected_hash = {
        date: date,
        person_id: student.id,
        book_id: book.id
      }

      expect(rental.to_hash).to eq expected_hash
    end
  end

  context 'rental gets added to the relevant person and book' do
    student = Student.new(nil, 14, 'Ali', id: 'student_id_1')
    book = Book.new('Book Title', 'The Author', id: 'book_id_1')
    date = '2015-12-05'

    rental = Rental.new(date, student, book)

    it 'adds rental to the person' do
      expect(student.rentals).to eq [rental]
    end

    it 'adds rental to the book' do
      expect(book.rentals).to eq [rental]
    end
  end
end
