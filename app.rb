class App
  def initialize
    @store = {
      persons: [],
    }
  end

  def list_all_people
    puts(@store[:persons].map { |p| "[#{p.class}] - id: #{p.id} | #{p.name} | #{p.age} years old"})

    home()
  end

  def create_person
    puts "What type of person to make?"
    options = {
      "1": "Student",
      "2": "Teacher"
    }

    for key, value in options do
      puts "#{key}) #{value}"
    end

    chosen_option = "-10000"
    until options.has_key?(chosen_option.to_sym)
      puts "Choose a valid option: \r"
      chosen_option = gets.chomp
    end

    puts 'Name?'
    name = gets.chomp
    puts 'Age?'
    age = gets.chomp

    if chosen_option == "1"
      puts 'Has parent permission? (Y/n)'
      permission_input = gets.chomp.downcase
      permission = permission_input == "n" ? false : true

      require './student'
      the_person = Student.new(nil, age, name, parent_permission: permission)
    else
      puts 'Specialization?'
      specialization = gets.chomp

      require './teacher'
      the_person = Teacher.new(specialization, age, name)
    end
    
    @store[:persons] << the_person
    
    home()
  end

  def home
    puts "Choose an option by entering its number:"
    options = {
      "1": "List all books",
      "2": "List all people",
      "3": "Create a person",
      "4": "Create a book",
      "5": "Create a rental",
      "6": "List all rentals for a given person id",
      "7": "Exit"
    }

    for key, value in options do
      puts "#{key}) #{value}"
    end

    chosen_option = "-10000"
    until options.has_key?(chosen_option.to_sym)
      puts "Choose a valid options: \r"
      chosen_option = gets.chomp
    end

    puts "Ok! You want to #{options[chosen_option.to_sym].downcase}"
    case chosen_option
    when "2"
      list_all_people()
    when "3"
      create_person()
    when "7"
      puts "See you soon. Bye! :)"
      exit()
    end
  end
  def run
    puts "Welcome. Tell me what should I do for you.\n\n"
    home()
  end
end
