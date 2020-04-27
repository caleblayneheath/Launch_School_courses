require 'sinatra'
require 'sinatra/reloader'

get "/" do
  sort = params['sort']
  
  contents = Dir.glob("public/*").map do |filename|
    shortname = File.basename(filename)
    "<p><a href=#{shortname}>#{shortname}</a></p>"
  end

  case sort
  when 'reverse'
    contents.reverse.append("<p><a href='/'>Sort alphabetically.</a></p>")
  else
    contents.append("<p><a href='/?sort=reverse'>Sort reverse alphabetically.</a></p>")
  end
end