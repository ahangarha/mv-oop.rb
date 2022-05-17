class Create
  def create(*items)
    @items = items
    raise NotImplementedError
  end

  def get_input(msg)
    print "#{msg} "
    gets.chomp
  end

  def choose_from(options)
    options.each { |key, value| puts "#{key}) #{value}" }

    chosen_option = '-10000'
    chosen_option = get_input('Your choice:') until options.key?(chosen_option.to_sym)

    chosen_option
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

class CreatePerson < Create
  def create
    puts 'What type of person to make?'
    options = {
      '1': 'Student',
      '2': 'Teacher'
    }

    chosen_option = choose_from(options)
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
