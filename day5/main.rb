#!/usr/bin/env ruby
require "ostruct"

FILE_PATH = "input.txt"

def binary_partition(max, min, list)
  return min if list.empty?

  letter = list.shift
  diff = (max - min) / 2
  if ["R", "B"].include? letter
    min = min + diff
  elsif ["L", "F"].include? letter
    max = min + diff
  end

  binary_partition(max, min, list)
end

def seats(seat_strings)
  seat_strings.map do |binary_seat|
    row = binary_partition(128, 0, binary_seat[0..7].split(""))
    column = binary_partition(8, 0, binary_seat[7..-1].split(""))
    OpenStruct.new(:row => row, :column => column, :id => row * 8 + column)
  end
end

def my_seat_id(seats)
  ids = seats.map(&:id)
  ((ids.min...ids.max).to_a - ids).first
end

input = File.open(FILE_PATH).read.split("\n")

seats = seats(input)
puts "Highest boarding pass id: #{seats.map(&:id).max}"

puts "My seat id: #{my_seat_id(seats)}"
