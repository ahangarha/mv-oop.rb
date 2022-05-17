require './display'

class App
  def initialize
    @store = {
      persons: [],
      books: [],
      rentals: []
    }

    @methods = {
      '1': 'list_all_books',
      '2': 'list_all_people',
      '3': 'create_person',
      '4': 'create_book',
      '5': 'create_a_rental',
      '6': 'list_rental_by_person_id',
      '7': 'exit'
    }
  end

  def list_all_books
    BooksDisplay.new(@store[:books]).list
  end

  def list_all_people
    PersonsDisplay.new(@store[:persons]).list
  end

  def create_person
    puts 'What type of person to make?'
    options = {
      '1': 'Student',
      '2': 'Teacher'
    }

    chosen_option = choose_from(options)
    
    name = getInput('Name:')
    age = getInput('Age:')

    the_person = chosen_option == '1' ? create_student(name, age) : create_teacher(name, age)

    @store[:persons] << the_person
    puts 'Saved.'
  end

  def create_book
    puts 'Please add details of the book'
    title = getInput('Title:')
    author = getInput('Author:')
    require './create'
    @store[:books] << CreateBook.new().create(title, author)
    puts 'Saved.'
  end

  def create_a_rental
    if @store[:books].length.zero? || @store[:persons].length.zero?
      puts 'Please make sure you have at least one person and one book in the database'
    else
      puts 'Choose a book:'
      @store[:books].each.with_index { |b, i| puts "#{i}) \"#{b.title}\" by: \"#{b.author}\"" }
      chosen_option = gets.chomp.to_i
      chosen_book = @store[:books][chosen_option]

      puts 'Choose a person:'
      @store[:persons].each.with_index { |p, i| puts "#{i}) [#{p.class}] Name: #{p.name}, id: #{p.id},  Age: #{p.age}" }
      chosen_option = gets.chomp.to_i
      chosen_person = @store[:persons][chosen_option]

      date = getInput('Pick a date:')

      require './rental'
      new_rental = Rental.new(date, chosen_person, chosen_book)
      @store[:rentals] << new_rental
    end
  end

  def list_rental_by_person_id
    # list persons
    if @store[:persons].length.zero?
      puts 'Invalid request. No persons found!'
      return nil
    end

    puts 'List of persons:'
    @store[:persons].each { |p| puts "#{p.id} - #{p.name}" }

    input_id = getInput('Enter the id of the person:')

    person = @store[:persons].find { |p| p.id == input_id }

    # list the rentals
    if person.nil?
      puts "Couldn't find any person with such id!"
    else
      show_rental_list(person)
    end
  end

  def show_rental_list(person)
    rentals = person.rentals
    RentalsDisplay.new(rentals).list
  end

  def home
    options = {
      '1': 'List all books',
      '2': 'List all people',
      '3': 'Create a person',
      '4': 'Create a book',
      '5': 'Create a rental',
      '6': 'List all rentals for a given person id',
      '7': 'Exit'
    }
    loop do
      puts "\nHere is the task list:"

      chosen_option = choose_from(options)

      puts "Ok! You want to #{options[chosen_option.to_sym].downcase}.\n\n"

      send(@methods[chosen_option.to_sym].to_sym)
    end
  end

  def run
    puts "Welcome. Tell me what should I do for you.\n"
    home
  end

  private

  def getInput (msg)
    print msg + ' '
    gets.chomp
  end

  def choose_from(options)
    options.each { |key, value| puts "#{key}) #{value}" }

    chosen_option = '-10000'
    until options.key?(chosen_option.to_sym)
      print 'Your choice: '
      chosen_option = gets.chomp
    end

    chosen_option
  end

  def create_student(name, age)
    print 'Has parent permission? (Y/n) '
    permission_input = gets.chomp.downcase
    permission = permission_input != 'n'

    require './student'
    Student.new(nil, age, name, parent_permission: permission)
  end

  def create_teacher(name, age)
    print 'Specialization: '
    specialization = gets.chomp

    require './teacher'
    Teacher.new(specialization, age, name)
  end
end
