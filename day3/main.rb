FILE_PATH = "input.txt"

def slope_hits(input, a, b)
  count = 0
  x = b
  y = a
  while x < input.count do
    count += 1 if input[x][y] == "#"
    x += b
    y = (y+a) % 31
  end
  count
end

input = File.open(FILE_PATH).read.split("\n").map { |a| a.split("") }

puts "Answer 1: #{slope_hits(input, 3, 1)}"
puts("Answer 2: #{
  slope_hits(input, 1, 1) *
  slope_hits(input, 3, 1) *
  slope_hits(input, 5, 1) *
  slope_hits(input, 7, 1) *
  slope_hits(input, 1, 2)
}")
