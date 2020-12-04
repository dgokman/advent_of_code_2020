A = File.read("aoc_2020_4.txt")

def all_include?(str)
  ["byr","iyr","eyr","hgt","hcl","ecl","pid"].each do |a|
    if !str.include?(a)
      return false
    end
  end
  true
end      

count = 0
A.split("\n\n").each do |a|
  if all_include?(a)
    count += 1
  end
end

p count

# 2

def valid?(str)
  idx = str.index("byr:")
  return false unless str[idx+4..idx+7].to_i.between?(1920,2002)
  idx = str.index("iyr:")
  return false unless str[idx+4..idx+7].to_i.between?(2010,2020)
  idx = str.index("eyr:")
  return false unless str[idx+4..idx+7].to_i.between?(2020,2030)
  idx = str.index("hgt:")
  if str.include?("cm")
    return false unless str[idx+4..idx+7].to_i.between?(150,193)
  else
    return false unless str[idx+4..idx+7].to_i.between?(59,76)
  end
  idx = str.index("hcl:")
  return false unless str[idx+4] == "#" && str[idx+5..idx+10].split("").all? {|z| (("a".."z").to_a + ("0".."9").to_a).include?(z)} && 
    !(("a".."z").to_a + ("0".."9").to_a).include?(str[idx+11])
  idx = str.index("ecl:")
  return false unless %w[amb blu brn gry grn hzl oth].include?(str[idx+4..idx+6])
  idx = str.index("pid:")
  return false unless str[idx+4..idx+12].split("").all? {|z| ("0".."9").to_a.include?(z)} && !("0".."9").to_a.include?(str[idx+13])
  true
end

count = 0
A.split("\n\n").each do |a|
  if all_include?(a) && valid?(a)
    count += 1
  end  
end  

p count
  