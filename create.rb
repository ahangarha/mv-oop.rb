class Create
  def self.create(data = {})
    raise NotImplementedError
  end

  def self.get_input(msg)
    print "#{msg} "
    gets.chomp
  end
end

class CreateBook < Create
  def self.create()
    puts 'Please add details of the book'
    title = Create.get_input('Title:')
    author = Create.get_input('Author:')

    require './book'
    Book.new(title, author)
  end
end

class CreateBooks < Create
  def self.create(books_list)
    books_list.map { |b| CreateBooks.create_object_of(b) }
  end

  def self.create_object_of(books_hash)
    require './book'
    Book.new(
      books_hash['title'],
      books_hash['author'],
      id: books_hash['id']
    )
  end
end

class CreatePersons < Create
  def self.create(persons_list)
    persons_list.map { |p| CreatePersons.create_object_of(p) }
  end

  def self.create_object_of(person_hash)
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
  def self.create
    puts 'What type of person to make?'
    options = {
      '1': 'Student',
      '2': 'Teacher'
    }

    require './menu'
    person_menu = Menu.new(options)
    chosen_option = person_menu.choose_from

    name = Create.get_input('Name:')
    age = Create.get_input('Age:')

    if chosen_option == '1'
      CreateStudent.create(name, age)
    else
      CreateTeacher.create(name, age)
    end
  end
end

class CreateStudent < Create
  def self.create(name, age)
    permission_input = Create.get_input('Has parent permission? (Y/n)').downcase
    permission = permission_input != 'n'

    require './student'
    Student.new(nil, age, name, parent_permission: permission)
  end
end

class CreateTeacher < Create
  def self.create(name, age)
    specialization = Create.get_input('Specialization:')

    require './teacher'
    Teacher.new(specialization, age, name)
  end
end

class CreateRental < Create
  def self.create(persons, books)
    puts 'Choose a book:'
    books.each.with_index { |b, i| puts "#{i}) \"#{b.title}\" by: \"#{b.author}\"" }
    chosen_option = gets.chomp.to_i
    chosen_book = books[chosen_option]

    puts 'Choose a person:'
    persons.each.with_index { |p, i| puts "#{i}) [#{p.class}] Name: #{p.name}, id: #{p.id},  Age: #{p.age}" }
    chosen_option = gets.chomp.to_i
    chosen_person = persons[chosen_option]

    date = Create.get_input('Pick a date:')

    require './rental'
    Rental.new(date, chosen_person, chosen_book)
  end
end

class CreateRentals < Create
  def self.create(rentals_list, all_persons, all_books)
    @all_persons = all_persons
    @all_books = all_books
    rentals_list.map { |r| CreateRentals.create_object_of(r) }
  end

  def self.create_object_of(rental)
    person = @all_persons.find { |p| p.id == rental['person_id'] }
    book = @all_books.find { |b| b.id == rental['book_id'] }
    Rental.new(
      rental['date'],
      person,
      book
    )
  end
end
