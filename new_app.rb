class App_Interface
  def initialize(context)
    @context = context
  end

  def run
    loop do
      continue = get_input
      break unless continue
    end
  end

  def get_input()
    raise NotImplementedError
  end
end

class Add_person_app < App_Interface
end
class Show_All_Books < App_Interface
  def get_input()
    # display all books
    false
  end

class Home_App < App_Interface

  def get_input
    #show home menu
    if user_input = 1
      Show_All_Books.new().run

  end
end

# in main.rb
home_app = Home_App.new(contexts)
home_app.run
