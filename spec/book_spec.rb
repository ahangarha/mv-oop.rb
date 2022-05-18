require './book'

describe Book do
  context "basic initialization of Book class" do
    title = "Dev"
    author = "John Doe"
    book = Book.new(title, author) 
      
    it "should expect the book title" do
      expect(book.title).to eq "Dev"
    end

    it "should expect the book author" do 
      expect(book.author).to eq "John Doe"
    end
  end

  context "initialization with id" do
    title = "Dev"
    author = "John Doe"
     
    it "generates unique id by default" do
      book = Book.new(title, author) 
      id = book.id
      expect(id.length).to be 36
    end
    it "generates unique id by default" do
      expected_id = '48245d31-3ef7-48e3-bf27-08f85f033977'
      book = Book.new(title, author, id: expected_id) 
      expect(book.id).to be expected_id
    end
  end
end
