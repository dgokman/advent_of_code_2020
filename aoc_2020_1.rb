A = File.read("aoc_2020_1.txt")
L = 2020

# 1
arr = A.split("\n").map(&:to_i)

arr.map(&:to_i).combination(2).each do |a,b|
  if a+b == L
    puts a*b
  end
end 

# 2

arr.combination(3).each do |a,b,c|
  if a+b+c == L
    puts a*b*c
  end
end    

