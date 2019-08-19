require 'yaml'
MESSAGES = YAML.load_file('loan_messages.yml')
LANG = 'en'

def prompt(message, add = '', lang = LANG)
  puts "=> #{MESSAGES[lang][message]}#{add}"
end

def calc_payment(amount, annual_rate, period)
  monthly_rate = annual_rate / 12
  if annual_rate == 0
    return amount / period
  else
    return amount * (monthly_rate / (1 - (1 + monthly_rate)**(-period)))
  end
end

def valid_number?(num)
  # only digits characters and up to one period are allowed
  num.chars.all? { |char| '0123456789.'.include?(char) } && num.count('.') < 2
end

prompt('welcome')

loop do
  loan_amount = 0
  loan_apr = 0
  loan_period = 0

  loop do
    prompt('enter_loan')
    loan_amount = gets.chomp
    if loan_amount.to_f >= 0 && valid_number?(loan_amount)
      loan_amount = (loan_amount).to_f
      break
    else
      prompt('invalid_loan')
    end
  end

  loop do
    prompt('enter_apr')
    loan_apr = gets.chomp
    if loan_apr.to_f >= 0 && valid_number?(loan_apr)
      loan_apr = loan_apr.to_f / 100
      break
    else
      prompt('invalid_apr')
    end
  end

  loop do
    prompt('enter_period')
    loan_period = gets.chomp
    if loan_period.to_i > 0 && valid_number?(loan_period)
      loan_period = loan_period.to_i
      break
    else
      prompt('invalid_period')
    end
  end

  payment = calc_payment(loan_amount, loan_apr, loan_period).to_s

  prompt('payment_is', "#{format('%2.2f', payment)}.")

  prompt('another_calc')
  break unless gets.chomp.downcase == 'y'
end

prompt('thanks')
