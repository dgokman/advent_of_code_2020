A = File.read("aoc_2020_6.txt")

arr = A.split("\n\n")

# 1
count = 0
arr.each do |str|
  count += (str.split("").flatten.uniq - ["\n"]).length
end

p count

# 2
count = 0
arr.each do |str|
  new_arr = str.split("\n")
  count += ("a".."z").to_a.select {|a| new_arr.all? {|b| b.include?(a)}}.length
end

p count