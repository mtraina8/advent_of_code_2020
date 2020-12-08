#!/usr/bin/env ruby

FILE_PATH = "input.txt"

def solve_1(input, color)
  current_colors = []
  input.each do |line|
    first, last = line.split(" bags contain")
    current_colors << first if last.include? color
  end
  return color if current_colors.empty?

  current_colors
    .map { |color| solve_1(input, color) }
    .flatten << color
end

def process_color(input, color)
  input
    .detect { |line| line.start_with? color }
    .split("bags contain")
    .last
    .split(",")
    .map { |item| item.gsub(" bags", "").gsub(" bag", "").gsub(".", "").split(" ", 2) }
    .map { |item| [item.last, item.first.to_i] }
    .to_h
end

def solve_2(input, color)
  related_colors = process_color(input, color)
  return 0 if related_colors.key? "other"

  related_colors.map do |color, count|
    count + count * solve_2(input, color)
  end.reduce(:+)
end

input = File.open(FILE_PATH).read.split(/\n/)

puts "Answer 1: #{solve_1(input, "shiny gold").uniq.count - 1}"
puts "Answer 2: #{solve_2(input, "shiny gold")}"

