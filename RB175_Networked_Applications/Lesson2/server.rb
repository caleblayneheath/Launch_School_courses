require 'socket'

# creating a server on localhost with port 3003
server = TCPServer.new("localhost", 3003)
loop do
  # waits until someone requests something from server,
  # accepts call, opens connection to client, returns client object
  client = server.accept
  
  # all text being sent from client to server, the HTTP request
  request_line = client.gets
  # prints out into console
  puts request_line

  # chrome expects well formed response, so line below required
  client.puts("HTTP/1.1 200 OK\r\n\r\n")
  
  # send response message body to client so it can appear in browser
  client.puts(request_line)

  client.close
end
