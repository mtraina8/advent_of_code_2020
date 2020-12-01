FILE_PATH = "input.txt"

def product_of_sum_to_2020(numbers, num)
  numbers
    .combination(num)
    .detect { |arr| arr.reduce(:+) == 2020 }
    .reduce(:*)
end

numbers = File.open(FILE_PATH).read.split.map(&:to_i)
puts "product of two number sum to 2020: #{product_of_sum_to_2020(numbers, 2)}"
puts "product of three number sum to 2020: #{product_of_sum_to_2020(numbers, 3)}"
