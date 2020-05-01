require 'socket'

def parse_request(request_line)
  http_method, path_and_params, http_version = request_line.split(/\s/)
  path, params = path_and_params.split('?')
  params = params.split('&').map{ |elem| elem.split('=') }.to_h

  [http_method, path, params, http_version]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept
  
  request_line = client.gets

  next if !request_line || request_line =~ /favicon/

  puts request_line

  http_method, path, params, http_version = parse_request(request_line)

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"
  
  client.puts "<h1>Rolls!</h1>"
  rolls = params['rolls'].to_i
  sides = params['sides'].to_i
  
  rolls.times { client.puts "<p>#{rand(1..sides)}</p>" }
  
  client.puts "</body>"
  client.puts "</html>"
  
  client.close
end