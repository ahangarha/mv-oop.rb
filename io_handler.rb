module IOHandler
  def self.get_input(msg, validationOptions = {pattern: /.*/, error_message: ''})
    print "#{msg} "
    input = gets.chomp.strip
    until validationOptions[:pattern].match? input
      puts validationOptions[:error_message]
      print "#{msg} "
      input = gets.chomp.strip
    end

    input
  end
end
