require './io_handler'

class Menu
  def initialize(options = {})
    @options = options
  end

  def choose_from(input_message = 'Your choice:')
    @options.each { |key, value| puts "#{key}) #{value}" }

    chosen_option = nil
    validation_options = { pattern: /^\d$/, error_message: 'You should enter a number!' }

    chosen_option = IOHandler.get_input(
      input_message, validation_options
    ) until !chosen_option.nil? && @options.key?(chosen_option)

    chosen_option
  end
end
