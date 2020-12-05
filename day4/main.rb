FILE_PATH = "input.txt"

def solve(input)
  lst = ["byr","iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  input.count do |passport|
    line = passport.gsub("\n", " ")
    items = line.split(" ")
    val = true
    val = false unless (lst - items.map{|a| a.split(":").first}).empty?
    puts val
    items.each do |item|
      k, v = item.split(":")
      case k
      when "byr"
        val = false unless v.size == 4
        val = false unless 1920 <= v.to_i && v.to_i <= 2002
      when "iyr"
        val = false unless v.size == 4
        val = false unless 2010 <= v.to_i && v.to_i <= 2020
      when "eyr"
        val = false unless v.size == 4
        val = false unless 2020 <= v.to_i && v.to_i <= 2030
      when "hgt"
        end_tag = v.split(//).last(2).join("")
        val = false unless ["in","cm"].include? end_tag
        num = v[0..-3]
        if end_tag == "cm"
          val = false unless 150 <= v.to_i && v.to_i <= 193
        elsif end_tag == "in"
          val = false unless 59 <= v.to_i && v.to_i <= 76
        else
          val = false
        end
      when "hcl"
        val = false unless v[0] == "#"
        val = false unless v[1..-1] =~ /[0-9a-z]/
      when "ecl"
        val = false unless ["amb","blu","brn","gry","grn","hzl","oth"].include? v
      when "pid"
        val = false if v.size != 9
      end
    end
    val
  end
end

passports = File.open(FILE_PATH).read.split(/\n{2,}/)
passports = passports.map { |a| a.gsub("\n", " ").split(" ") }



puts "Answer 1: #{solve(input)}"
