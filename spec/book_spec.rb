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
end
