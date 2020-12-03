A = File.read("aoc_2020_3.txt")
arr = []
A.split("\n").each do |a|
  arr << a*100
end  

i = 0
j = 0
count = 0
while i < arr.length
  while arr[i] && j < arr[i].length
    i += 1
    j += 3
    if arr[i] && arr[i][j] && arr[i][j] == "#"
      count += 1
    end
  end
end

p count 

# 2
total = 1
[[1,1],[3,1],[5,1],[7,1],[1,2]].each do |jj,ii|
  i = 0
  j = 0
  count = 0
  while i < arr.length
    while arr[i] && j < arr[i].length
      i += ii
      j += jj
      if arr[i] && arr[i][j] && arr[i][j] == "#"
        count += 1
      end
    end
  end
  total *= count
end

p total  
       


