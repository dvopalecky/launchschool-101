# Loan Calculator

THOUSAND_SEPARATOR = ","
DECIMAL_POINT = "."

def prompt(message)
  puts "=> #{message}"
end

def valid_positive_integer?(input_str)
  input_str.to_i.to_s == input_str
end

def valid_nonnegative_float?(input_str)
  /\d/.match(input_str) && /^\d*\.?\d*$/.match(input_str)
end

def enter_integer(message)
  number = nil
  loop do
    prompt message
    number = gets.chomp
    if valid_positive_integer?(number)
      break
    else
      prompt "Please enter a valid positive integer."
    end
  end
  number.to_i
end

def enter_float(message)
  number = nil
  loop do
    prompt message
    number = gets.chomp
    if valid_nonnegative_float?(number)
      break 
    else
      prompt "Please enter a valid non-negative number."
    end
  end
  number.to_f
end

def monthtly_payment(interest_rate_in_percent, principal, maturity_in_years)
  monthly_interest_rate = interest_rate_in_percent / 12 / 100
  number_of_payments = maturity_in_years * 12
  principal * (monthly_interest_rate /
    (1 - (1 + monthly_interest_rate)**-number_of_payments))
end

def format_float(input_float)
  # converts to string and only to 2 decimal places
  formatted = format("%.2f", input_float)
  before_and_after_decimal = formatted.split(DECIMAL_POINT) # [before, after]
  before_decimal = before_and_after_decimal[0].reverse.scan(/\d{1,3}/)
                                              .join(THOUSAND_SEPARATOR).reverse
  before_decimal + DECIMAL_POINT + before_and_after_decimal[1]
end

# main
prompt "Loan Calculator 0.1"
loop do
  msg = "Enter interest rate (in %, per annum. Ex: 1.89 for 1.89%)"
  interest_rate = enter_float(msg)
  msg = "Enter loan amount = principal (Ex. 100000 for $100,000)"
  principal = enter_float(msg)
  maturity = enter_integer("Enter loan duration (in years) (Ex. 30)")

  prompt "Interest rate p.a. (%) : #{format_float(interest_rate)}"
  prompt "Principal ($)          : #{format_float(principal)}"
  prompt "Loan duration (yrs)    : #{maturity}"
  prompt "------------------------------------"
  result = monthtly_payment(interest_rate, principal, maturity)
  prompt "Monthly payment ($)    : #{format_float(result)}"
  prompt ""
  prompt "Do you want to calculate again? (Y) for yes"
  break unless gets.chomp.upcase == "Y"
end
