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

count_arr = []
jolts.each do |n|
  for o in 1..3
    if jolts.include?(n+o)
      count_arr[n+o] ||= 0
      count_arr[n+o] += count_arr[n].to_i > 0 ? count_arr[n] : 1
    end  
  end
end

p count_arr.last

  
