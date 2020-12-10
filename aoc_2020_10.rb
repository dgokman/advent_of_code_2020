A = File.read("aoc_2020_10.txt")

# 1

jolts = A.split("\n").map(&:to_i).sort
goal = jolts.max

diffs = jolts.each_cons(2).map {|a,b| b-a}
p (diffs.count(1)+1)*(diffs.count(3)+1)

# 2

jolts << 0 << goal
jolts.sort!
hash = {}

jolts.each do |a|
  hash[a] ||= []
  [1,2,3].each do |n|
    hash[a] << a+n if jolts.include?(a+n)
  end  
end

count_arr = []
jolts.each do |n|
  hash[n].each do |o|
    count_arr[o] ||= 0
    count_arr[o] += count_arr[n].to_i > 0 ? count_arr[n] : 1
  end
end

p count_arr.last

  
