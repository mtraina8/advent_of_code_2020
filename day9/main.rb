#!/usr/bin/env ruby

FILE_PATH = "input.txt"

def invalid_number(input)
  i = 25
  loop do
    preamble = input[i-25...i]
    value = input[i]
    return value unless valid?(value, preamble)
    i += 1
  end
end

def valid?(value, preamble)
  options = []
  preamble.each do |p|
    preamble.each do |q|
      options << p + q unless q == p
    end
  end

  options.include? value
end

def contiguous(input, value)
  list = []
  i = 0

  loop do
    input[i..-1].each do |num|
      list << num
      contiguous_total = list.reduce(&:+)

      if contiguous_total > value
        list = []
        break
      elsif contiguous_total == value
        return list.min + list.max
      end
    end

    i += 1
    return "not found" if i >= input.count
  end
end

input = File.open(FILE_PATH).read.split(/\n/).map(&:to_i)

puts "Answer 1: #{invalid_number(input)}"
puts "Answer 2: #{contiguous(input, invalid_number(input))}"
