#!/usr/bin/env ruby
require "ostruct"

FILE_PATH = "input.txt"

def solve_1(input)
  input.map do |line|
    line.gsub(" ","").split("").uniq.join("").size
  end
end

def solve_2(input)
  input.map do |line|
    unique_chrs = line.gsub(" ","").split("").uniq
    inputs = line.split(" ")
    unique_chrs.count do |item|
      inputs.all? { |a| a.include? item }
    end
  end
end

input = File.open(FILE_PATH).read.split(/\n{2,}/)
input = input.map { |a| a.gsub("\n", " ") }

puts "Answer 1: #{solve_1(input).reduce(0, :+)}"
puts "Answer 2: #{solve_2(input).reduce(0, :+)}"
