#!/usr/bin/env ruby

FILE_PATH = "input.txt"

def boot_code_processor(boot_code, modify_source_code:)
  lines_hit = []
  total = 0
  attempt = 0
  jmp_nop_count = 0
  i = 0

  loop do
    return total if i == boot_code.length
    if lines_hit.include? i
      return total unless modify_source_code
      attempt += 1
      lines_hit = []
      total = 0
      jmp_nop_count = 0
      i = 0
    end
    lines_hit << i

    instruction, signed_num = boot_code[i].split(" ")

    case instruction
    when "jmp"
      if attempt == jmp_nop_count
        i += 1 # behave like nop
      else
        i += signed_num.to_i
      end
      jmp_nop_count += 1
    when "acc"
      total += signed_num.to_i
      i += 1
    when "nop"
      if attempt == jmp_nop_count
        i += signed_num.to_i # behave like jmp
      else
        i += 1
      end
      jmp_nop_count += 1
    end
  end
end

input = File.open(FILE_PATH).read.split(/\n/)

puts "Answer 1: #{boot_code_processor(input, modify_source_code: false)}"
puts "Answer 2: #{boot_code_processor(input, modify_source_code: true)}"
