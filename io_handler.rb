module IOHandler
  def self.get_input(msg, validation_options = { pattern: /.*/, error_message: '' })
    print "#{msg} "
    input = gets.chomp.strip
    until validation_options[:pattern].match? input
      puts validation_options[:error_message]
      print "#{msg} "
      input = gets.chomp.strip
    end

    input
  end
end
