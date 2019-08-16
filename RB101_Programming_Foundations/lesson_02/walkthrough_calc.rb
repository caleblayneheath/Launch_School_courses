# ask the user for two numbers
# ask user for an operation to perform
# perform operation on two numbers
# output result

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i() != 0
end

def operator_to_message(op)
  result =  case op
            when '1'
              'Adding'
            when '2'
              'Subtracting'
            when '3'
              'Multiplying'
            when '4'
              'Dividing'
            end
  result
end

prompt("Welcome to Calculator! Enter your name:")

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt("Enter your name.")
  else
    break
  end
end

puts("Hello #{name}.")

loop do
  number1 = ''
  loop do
    prompt("What's the first number?")
    number1 = Kernel.gets().chomp().to_i

    if valid_number?(number1)
      break
    else
      prompt("Not a valid number.")
    end
  end

  number2 = ''
  loop do
    prompt("What's the second number?")
    number2 = Kernel.gets().chomp().to_i

    if valid_number?(number2)
      break
    else
      prompt("Not a valid number.")
    end
  end

  operator_prompt = <<-MSG
    What's the operation?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Choose a valid operator")
    end
  end

  prompt("#{operator_to_message(operator)} the two numbers...")

  result =  case operator
            when '1'
              number1 + number2
            when '2'
              number1 - number2
            when '3'
              number1 * number2
            when '4'
              number1 / number2.to_f()
            end

  prompt("The result is #{result}")

  prompt("Do you want to perfom another calculation? (Y/N)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using Calculator. Goodbye.")
