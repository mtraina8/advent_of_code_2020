#!/usr/bin/env ruby
FILE_PATH = "input.txt"

def count_adjacent(xi, yi, seating_grid)
  count = 0
  (xi - 1..xi + 1).each do |x|
    (yi - 1..yi + 1).each do |y|
      next if x < 0 || y < 0 || x >= seating_grid.count || y >= seating_grid[x].count || (x == xi && y == yi)
      count += 1 if seating_grid[x][y] == "#"
    end
  end
  count
end

def count_first_seat(xi, yi, seating_grid)
  lists = []
  count = 0
  max_x = seating_grid.count
  max_y = seating_grid.first.count

  lists << (0...xi).to_a.reverse.map { |x| seating_grid[x][yi] }                                # top
  lists << ((xi + 1)...max_x).map { |x| seating_grid[x][yi] }                                   # botom
  lists << ((yi + 1)...max_y).map { |y| seating_grid[xi][y] }                                   # right
  lists << (0...yi).to_a.reverse.map { |y| seating_grid[xi][y] }                                # left
  lists << (1..[yi, xi].min).to_a.map { |i| seating_grid[(xi - i)][(yi - i)] }                  # top left
  lists << (1..[(max_x - xi - 1), yi].min).to_a.map { |i| seating_grid[(xi + i)][(yi - i)] }    # bottom left
  lists << (1..[xi, (max_y - yi - 1)].min).to_a.map { |i| seating_grid[(xi - i)][(yi + i)] }    # top right
  lists << (1...[max_x - xi, max_y - yi].min).to_a.map { |i| seating_grid[(xi + i)][(yi + i)] } # bottom right


  lists.each do |list|
    value = list.detect { |a| a == "#" || a == "L" }
    count += 1 if value == "#"
  end

  count
end

def seating_rules(seating_grid, seating_req)
  while true
    new_seating_grid = Array.new(seating_grid.count) { Array.new(seating_grid.first.count) }

    seating_grid.each_with_index do |line, x|
      line.each_with_index do |value, y|
        count = seating_req ? count_adjacent(x, y, seating_grid) : count_first_seat(x, y, seating_grid)

        if value == "L" && count == 0
          new_seating_grid[x][y] = "#"
        elsif value == "#" && (seating_req ? count >= 4 : count >= 5)
          new_seating_grid[x][y] = "L"
        else
          new_seating_grid[x][y] = value
        end
      end
    end

    break if new_seating_grid == seating_grid
    seating_grid = new_seating_grid
  end

  seating_grid.flatten.count("#")
end

input = File.open(FILE_PATH).read.split(/\n/).map { |line| line.split("") }

puts "Answer 1: #{seating_rules(input, true)}"
puts "Answer 2: #{seating_rules(input, false)}"
