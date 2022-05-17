class Display
  def initialize(items)
    @items = items
  end

  def list
    raise NotImplementedError
  end
end

class PersonsDisplay < Display
  def list
    if @items.length.zero?
      puts('no items found')
    else
      @items.each { |p| puts("[#{p.class}] - id: #{p.id} | #{p.name} | #{p.age} years old") }
    end
  end
end

class BooksDisplay < Display
  def list
    if @items.length.zero?
      puts('no items found')
    else
      puts(@items.map { |b| "Title: \"#{b.title}\", Author: \"#{b.author}\"" })
    end
  end
end

class RentalsDisplay < Display
  def list
    if @items.length.zero?
      puts 'This person doesn\'t have any rental!'
    else
      puts "Rental records for this person:\n\n"
      @items.each { |r| puts "Data: #{r.date} - Book: \"#{r.book.title}\" by \"#{r.book.author}\"" }
    end
  end
end

class ListRentalsByPersonId < Display
 def list
  # list persons
  if items.length.zero?
    puts 'Invalid request. No persons found!'
    return nil
  end

  puts 'List of persons:'
  items.each { |p| puts "#{p.id} - #{p.name}" }

  print 'Enter the id of the person: '
  input_id = gets.chomp

  person = items.find { |p| p.id == input_id }

  # list the rentals
  if person.nil?
    puts "Couldn't find any person with such id!"
  else
    show_rental_list(person)
  end

  def show_rental_list(person)
    rentals = person.rentals
    RentalsDisplay.new(rentals).list
  end
 end
end