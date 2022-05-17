class Create
  def create(*items)
    @items = items
    raise NotImplementedError
  end
end

class CreateBook < Create
  def create(title, author)
    require './book'
    Book.new(title, author)
  end
end
