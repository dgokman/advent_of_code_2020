require 'set'

A = File.read("aoc_2020_8.txt")

@a = 0
@l = 0
def acc(val)
  @a += val
  @l += 1
end

def jmp(line)
  @l += line
end

def nop(val) 
  @l += 1
end  

def run_rule(func, val)
  send(func.to_sym, val)
end  


# 1
done_rules = Set.new
rules = A.split("\n")

loop do
  if done_rules.include?(@l)
    puts @a
    break
  end
  done_rules << @l  
  func, val = rules[@l].split(" ")
  val = val.to_i
  
  run_rule(func, val)
end  

# 2

rules.length.times do |i|
  @a = 0
  @l = 0
  next if rules[i][0..2] == "acc"

  new_rules = Marshal.load(Marshal.dump(rules))

  if new_rules[i][0..2] == "nop"
    new_rules[i][0..2] = "jmp"
  else
    new_rules[i][0..2] = "nop"
  end  

  count = 0

  loop do
    if @l >= rules.length
      puts @a
      break
    end  
    if count > rules.length
      break
    end  
    
    func, val = new_rules[@l].split(" ")
    val = val.to_i
    
    run_rule(func, val)
    count += 1
  end
end  

