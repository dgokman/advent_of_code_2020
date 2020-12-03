A = File.read("aoc_2020_2.txt")

# 1

count = 0
A.split("\n").map {|a| a.split(":")}.each do |a, b|
  nums, letter = a.split(" ")
  nums = nums.split("-")
  if b.count(letter).between?(nums[0].to_i, nums[1].to_i)
    count += 1
  end  
end  

p count

# 2
count = 0
A.split("\n").map {|a| a.split(":")}.each do |a, b|
  b.strip!
  nums, letter = a.split(" ")
  nums = nums.split("-")
  if [b[nums[0].to_i-1] == letter, b[nums[1].to_i-1] == letter].count(true) == 1
    count += 1
  end  
end  

p count
