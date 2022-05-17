require './display'
require './create'

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
    @store[:persons] << CreatePerson.new.create
    puts 'Saved.'
  end

  def create_book
    @store[:books] << CreateBook.new.create
    puts 'Saved.'
  end

  def create_a_rental
    if @store[:books].length.zero? || @store[:persons].length.zero?
      puts 'Please make sure you have at least one person and one book in the database'
    else
      @store[:rentals] << CreateRental.new.create(@store[:persons], @store[:books])
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

    input_id = get_input('Enter the id of the person:')

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
