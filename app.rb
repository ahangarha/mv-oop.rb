require './display'
require './create'
require './menu'

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
      '7': 'quit'
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
    ListRentalsByPersonId.new(@store[:persons]).list
  end

  def quit
    require './storage'
    Storage.new('persons').save(@store[:persons])
    Storage.new('books').save(@store[:books])
    Storage.new('rentals').save(@store[:rentals])

    exit
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

      home_menu = Menu.new(options)
      chosen_option = home_menu.choose_from

      puts "Ok! You want to #{options[chosen_option.to_sym].downcase}.\n\n"

      send(@methods[chosen_option.to_sym].to_sym)
    end
  end

  def run
    puts "Welcome. Tell me what should I do for you.\n"
    home
  end
end
