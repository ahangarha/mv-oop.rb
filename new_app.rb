require './menu'
require 'pry'

class App
  attr_reader :title
  attr_accessor :apps

  def initialize(title, apps = [])
    @title = title
    @apps = apps
    @state = {}
  end

  def generate_menu_options
    options = {}
    @apps.each.with_index { |app, index| options[index.to_s] = app.title }
    options
  end

  def run
    options = generate_menu_options
    chosen_option = Menu.new(options).choose_from('Choose one option from the menu:')
    @apps[chosen_option.to_i].run
  end

  def run_loop
    loop do
      run
    end
  end
end

class CountApp < App
  def run
    # super
    5.times.with_index { |i| puts i }
  end
end

class HomeApp < App
end

count_app = CountApp.new('Count from 0 to 5')


# And this way we make an app with sub apps
home_app = HomeApp.new('Home app', [
  count_app
])

home_app.run_loop
