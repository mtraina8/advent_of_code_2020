#!/usr/bin/env ruby

FILE_PATH = "input.txt"

def one_three_volt_differences(input)
  differences = []
  last = 0

  input.each do |joltage|
    differences << joltage - last
    last = joltage
  end

  differences.count(1) * differences.count(3)
end

def arrangements(value, input, hash)
  return hash[value] if hash[value]

  valid_options = input.select { |item| item > value && item <= value + 3 }
  return 1 if valid_options.empty?

  valid_options.sum do |option|
    v = arrangements(option, input, hash)
    hash[option] = v
  end
end

input = File.open(FILE_PATH).read.split(/\n/).map(&:to_i)
input = input.push(0, input.max + 3).sort
hash = {}

puts "Answer 1: #{one_three_volt_differences(input)}"

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Answer 2: #{arrangements(input.min, input, hash)}"
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Finished in #{ending - starting}"
