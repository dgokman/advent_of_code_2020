A = File.read("aoc_2020_14.txt")

# 1

rules = A.split("\n")
mask, addr, val = nil
bits = []
rules.each do |a|
  if a.include?("mask")
    mask = a.split(" = ").last
  end
  if a.include?("mem")
    vals = a.split(" = ")
    addr = vals[0][4..-2].to_i
    value = vals[1].to_i.to_s(2)
    len = value.length
    value = "0"*(36-len) + value
    new_val = ""
    for i in 0..35
      if ["0","1"].include?(mask[i])
        new_val[i] = mask[i]
      elsif mask[i] == "X"
        new_val[i] = value[i]
      end
    end
    bits[addr] = new_val.to_i(2)   
  end
end  

p bits.compact.inject(:+)

# 2

mask, addr, val = nil
bits = {}
rules.each do |a|
  if a.include?("mask")
    mask = a.split(" = ").last
  end
  if a.include?("mem")
    vals = a.split(" = ")
    addr = vals[0][4..-2].to_i
    value_og = vals[1].to_i
    len = addr.to_s(2).length
    value = "0"*(36-len) + addr.to_s(2)
    new_val = ""
    floats = []
    for i in 0..35
      
      if mask[i] == "0"
        new_val[i] = value[i]
      elsif mask[i] == "1"
        new_val[i] = "1"
      elsif mask[i] == "X"
        floats << i
        new_val[i] = "f"
      end
    end
    possibles = ["0","1"].repeated_permutation(floats.length).to_a
    new_new_val = ""
    possibles.each do |p|
      new_new_val = new_val.clone
      p.each_with_index do |bit, idx|
        new_new_val[floats[idx]] = bit
      end  
      bits[new_new_val.to_i(2)] = value_og
    end   
  end
end 

p bits.values.inject(:+)