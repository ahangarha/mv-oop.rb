class Create
  def create(data = {})
    @data = data
    raise NotImplementedError
  end

  def get_input(msg)
    print "#{msg} "
    gets.chomp
  end
end

class CreateBook < Create
  def create()
    puts 'Please add details of the book'
    title = get_input('Title:')
    author = get_input('Author:')

    require './book'
    Book.new(title, author)
  end
end

class CreateBooks < Create
  def create(books_list)
    books_list.map { |b| create_object_of(b) }
  end

  def create_object_of(books_hash)
    require './book'
    Book.new(
      books_hash['title'],
      books_hash['author'],
      id: books_hash['id']
    )
  end
end

class CreatePersons < Create
  def create(persons_list)
    persons_list.map { |p| create_object_of(p) }
  end

  def create_object_of(person_hash)
    case person_hash['class']
    when 'Student'
      require './student'
      Student.new(
        person_hash['classroom'],
        person_hash['age'],
        person_hash['name'],
        parent_permission: person_hash['parent_permission'],
        id: person_hash['id']
      )
    when 'Teacher'
      require './teacher'
      Teacher.new(
        person_hash['specialization'],
        person_hash['age'],
        person_hash['name'],
        id: person_hash['id']
      )
    end
  end
end

class CreatePerson < Create
  def create
    puts 'What type of person to make?'
    options = {
      '1': 'Student',
      '2': 'Teacher'
    }

    require './menu'
    person_menu = Menu.new(options)
    chosen_option = person_menu.choose_from

    name = get_input('Name:')
    age = get_input('Age:')

    if chosen_option == '1'
      CreateStudent.new.create(name, age)
    else
      CreateTeacher.new.create(name, age)
    end
  end
end

class CreateStudent < Create
  def create(name, age)
    permission_input = get_input('Has parent permission? (Y/n)').downcase
    permission = permission_input != 'n'

    require './student'
    Student.new(nil, age, name, parent_permission: permission)
  end
end

class CreateTeacher < Create
  def create(name, age)
    specialization = get_input('Specialization:')

    require './teacher'
    Teacher.new(specialization, age, name)
  end
end

class CreateRental < Create
  def create(persons, books)
    puts 'Choose a book:'
    books.each.with_index { |b, i| puts "#{i}) \"#{b.title}\" by: \"#{b.author}\"" }
    chosen_option = gets.chomp.to_i
    chosen_book = books[chosen_option]

    puts 'Choose a person:'
    persons.each.with_index { |p, i| puts "#{i}) [#{p.class}] Name: #{p.name}, id: #{p.id},  Age: #{p.age}" }
    chosen_option = gets.chomp.to_i
    chosen_person = persons[chosen_option]

    date = get_input('Pick a date:')

    require './rental'
    Rental.new(date, chosen_person, chosen_book)
  end
end

class CreateRentals < Create
  def create(rentals_list, all_persons, all_books)
    @all_persons = all_persons
    @all_books = all_books
    rentals_list.map { |r| create_object_of(r) }
  end

  def create_object_of(r)
    person = @all_persons.select { |p| p.id == r['person_id'] } 
    book = @all_books.select { |b| b.id  == r['book_id'] }
    Rental.new(
      r['date'],
      person,
      book
    )
  end
end
