FILE_PATH = "input.txt"

def valid_password_count_policy_1(input)
  input.count do |line|
    range, letter, pass = line.split(" ")
    range = range.split("-").map(&:to_i)
    letter = letter.tr(":", "")

    pass.count(letter).between?(range.first, range.last)
  end
end

def valid_password_count_policy_2(input)
  input.count do |line|
    position, letter, pass = line.split(" ")
    positions = position.split("-").map(&:to_i)
    letter = letter.tr(":", "")

    [pass[positions.first - 1], pass[positions.last - 1]].count(letter) == 1
  end
end

input = File.open(FILE_PATH).read.split("\n")
puts valid_password_count_policy_1(input)
puts valid_password_count_policy_2(input)
