require './io_handler'

class Menu
  def initialize(options = {})
    @options = options
  end

  def choose_from(input_message = 'Your choice:')
    @options.each { |key, value| puts "#{key}) #{value}" }

    chosen_option = nil
    chosen_option = IOHandler::get_input(input_message) until !chosen_option.nil? && @options.key?(chosen_option.to_sym)

    chosen_option
  end
end
