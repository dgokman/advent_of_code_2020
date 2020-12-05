A = File.read("aoc_2020_5.txt")

def seat_id(str)
  min = 0
  max = 127
  chunk = max+1
  6.times do |n|
    chunk /= 2
    if str[n] == "F"
      max -= chunk
    else
      min += chunk
    end
  end 
  row = str[6] == "F" ? min : max
  
  min = 0
  max = 7
  chunk = max+1
  2.times do |n|
    n = n+7
    chunk /= 2
    if str[n] == "L"
      max -= chunk
    else
      min += chunk
    end
  end
  column = str[9] == "L" ? min : max 
  [row, column] 
end

# 1 

p A.split("\n").map {|a| seat_id(a)}.map {|b,c| b*8+c}.max

# 2
hash = {}
A.split("\n").each do |str|
  row, column = seat_id(str)
  hash[row] ||= []
  hash[row] << column
end

seat = hash.select {|k,v| v.sort != (0..7).to_a}
p seat.first.to_a.first * 8 + ((0..7).to_a - seat.first.to_a.last).first




