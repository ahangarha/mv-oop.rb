class App
  def initialize
    @store = {
      persons: [],
      books: [],
      rentals: []
    }
  end

  def list_all_books
    if @store[:books].length.zero?
      puts 'There is no book!'
    else
      puts(@store[:books].map { |b| "Title: \"#{b.title}\", Author: \"#{b.author}\"" })
    end

    puts
    home
  end

  def list_all_people
    if @store[:persons].length.zero?
      puts 'There is no people!'
    else
      puts(@store[:persons].map { |p| "[#{p.class}] - id: #{p.id} | #{p.name} | #{p.age} years old" })
    end

    puts
    home
  end

  def create_person
    puts 'What type of person to make?'
    options = {
      '1': 'Student',
      '2': 'Teacher'
    }

    options.each { |key, value| puts "#{key}) #{value}" }

    chosen_option = '-10000'
    until options.key?(chosen_option.to_sym)
      print 'Choose a valid option: '
      chosen_option = gets.chomp
    end

    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp

    if chosen_option == '1'
      print 'Has parent permission? (Y/n) '
      permission_input = gets.chomp.downcase
      permission = permission_input != 'n'

      require './student'
      the_person = Student.new(nil, age, name, parent_permission: permission)
    else
      print 'Specialization: '
      specialization = gets.chomp

      require './teacher'
      the_person = Teacher.new(specialization, age, name)
    end

    @store[:persons] << the_person
    puts 'Saved.'

    puts
    home
  end

  def create_book
    puts 'Please add details of the book'

    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    require './book'
    the_book = Book.new(title, author)

    @store[:books] << the_book
    puts 'Saved.'

    puts
    home
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

      puts 'Pick a date:'
      date = gets.chomp

      require './rental'
      new_rental = Rental.new(date, chosen_person, chosen_book)
      @store[:rentals] << new_rental
    end

    puts
    home
  end

  def list_rental_by_person_id
    # list persons
    print 'Enter the id of the person: '
    input_id = gets.chomp

    person = @store[:persons].find { |p| p.id == input_id }

    # list the rentals
    if person.nil?
      puts "Couldn't find any person with such id!"
    else
      rentals = person.rentals
      rentals.each { |r| puts "Data: #{r.date} - Book: \"#{r.book.title}\" by \"#{r.book.author}\"" }
    end

    puts
    home
  end

  def home
    puts 'Here is the task list:'
    options = {
      '1': 'List all books',
      '2': 'List all people',
      '3': 'Create a person',
      '4': 'Create a book',
      '5': 'Create a rental',
      '6': 'List all rentals for a given person id',
      '7': 'Exit'
    }

    options.each { |key, value| puts "#{key}) #{value}" }

    chosen_option = '-10000'
    until options.key?(chosen_option.to_sym)
      print 'Enter the number of the task: '
      chosen_option = gets.chomp
    end

    puts "Ok! You want to #{options[chosen_option.to_sym].downcase}.\n\n"

    case chosen_option
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_a_rental
    when '6'
      list_rental_by_person_id
    when '7'
      puts 'See you soon. Bye! :)'
      exit
    end
  end

  def run
    puts "Welcome. Tell me what should I do for you.\n\n"
    home
  end
end
