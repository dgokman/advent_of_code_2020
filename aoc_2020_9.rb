require 'set'

A = File.read("aoc_2020_9.txt")

arr = A.split("\n").map(&:to_i)

i = 25
val = 0
while i < arr.length
  combos = arr[i-25..i-1].combination(2).map {|a,b| a+b}.to_set
  if !combos.include?(arr[i])
    val = arr[i]
  end
  i += 1
end    

p val

i = 0
j = 0
done = false
while i < arr.length
  break if done
  while j < arr.length
    if arr[i..j].inject(:+) == val
      p arr[i..j].min + arr[i..j].max
      done = true
    end
    j += 1
  end
  i += 1
  j = i
end  


