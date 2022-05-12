class App

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
