class App_Interface
  def initialize
    #
  end

  def run
    loop do
      get_input
    end
  end

  def get_input(context)
    raise NotImplementedError
  end
end

class Add_person_app < App_Interface


class Home_App < App_Interface
  def run
    
  end

  def get_input
    #show home menu
    if user_input = 1

  end
end

# in main.rb
app = new New_App.new(contexts)
app.run
