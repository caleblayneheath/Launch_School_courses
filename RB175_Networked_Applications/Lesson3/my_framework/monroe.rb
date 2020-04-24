class Monroe
  def response(status, headers)
    body = yield if block_given?
    [status, headers, [body]]
  end

  def erb(filename, local = {})
    b = binding # creates a binding which is later passed into result?
    message = local[:message] # message from local assigned to local var
    content = File.read("views/#{filename}.erb")
    ERB.new(content).result(b) # local vars accessible in erb because binding passed in
  end
end