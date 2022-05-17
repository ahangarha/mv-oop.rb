class Create
  def create(*items)
    @items = items
    raise NotImplementedError
  end

end

class CreateBook < Create
  def create(title, author)
    require './book'
    the_book = Book.new(title, author)
    the_book
  end
end
