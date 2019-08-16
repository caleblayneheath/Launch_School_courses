require 'pry'
require 'yaml'
MESSAGES = YAML.load_file('/home/clh/Launch_School_courses/RB101_Programming_Foundations/lesson_02/calc_messages.yml')

def prompt(message)
  puts("=> #{message}")
end

def valid_number?(num)
  #only digits characters and up to one period are allowed
  num.chars.all? { |char| '0123456789.'.include?(char) } && num.count('.') < 2
end

def operator_to_message(op)
  result =  case op
            when '1'
              MESSAGES['adding']
            when '2'
              MESSAGES['subtracting']
            when '3'
              MESSAGES['multiplying']
            when '4'
              MESSAGES['dividing']
            end
  result
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = gets().chomp()

  if name.empty?()
    prompt(MESSAGES['enter_name'])
  else
    break
  end
end

prompt(MESSAGES['greetings'] + "#{name}.")

loop do
  number1 = ''
  loop do
    prompt(MESSAGES['first_number'])
    number1 = gets().chomp()

    if valid_number?(number1)
      number1 = number1.to_f
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES['second_number'])
    number2 = gets().chomp()

    if valid_number?(number2)
      number2 = number2.to_f
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end

  # operator_prompt = <<-MSG
  #   What's the operation?
  #   1) add
  #   2) subtract
  #   3) multiply
  #   4) divide
  # MSG
  prompt(MESSAGES['operator_prompt'])

  operator = ''
  loop do
    operator = gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['invalid_operator'])
    end
  end

  prompt("#{operator_to_message(operator)} #{MESSAGES['working']}")

  result =  case operator
            when '1'
              number1 + number2
            when '2'
              number1 - number2
            when '3'
              number1 * number2
            when '4'
              number1 / number2
            end

  prompt(MESSAGES['result'] + result.to_s)

  prompt(MESSAGES['another_calc'])
  answer = gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(MESSAGES['thanks'])
