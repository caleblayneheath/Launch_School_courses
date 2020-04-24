# config.ru

# below is the file containing our ruby app
require_relative 'app'

# below is our app, called as a new HelloWorld object
run App.new