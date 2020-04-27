require 'tilt/erubis'
require "sinatra"
require "sinatra/reloader" # application reloads files every time a page is loaded, very nice apparently?

# when path is /, read template file and send returned string to browser when GET
get "/" do
  @title = "The Adventures of Sherlock Holmes"
  @contents = File.readlines "data/toc.txt"

  erb :home
end

get "/chapters/1" do
  @title = "Chapter 1"
  @contents = File.readlines "data/toc.txt"
  @chapter = File.readlines "data/chp1.txt"

  erb :chapter
end
