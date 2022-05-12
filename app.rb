class App
  def initialize
    @store = {
      persons: [],
      books: []
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
