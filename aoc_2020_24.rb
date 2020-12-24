A = File.read("aoc_2020_24.txt")

tiles = A.split("\n")
L = 250

arr = Array.new(L){Array.new(L){"W"}}
neighbors = {"nw"=>[-1,-1],"ne"=>[-1,1],"w"=>[0,-2],"e"=>[0,2],"sw"=>[1,-1],"se"=>[1,1]}

def parse_dirs(dirs)
  new_dirs = []
  i = 0
  while i < dirs.length
    if ["e", "w"].include?(dirs[i])
      new_dirs << dirs[i]
      i += 1
    else
      new_dirs << dirs[i..i+1]
      i += 2 
    end
  end
  new_dirs
end           

tiles.each do |dirs|
  new_dirs = parse_dirs(dirs)
  i = L/2
  j = L/2
  new_dirs.each do |dir|
    ii, jj = neighbors[dir]
    i += ii
    j += jj
  end 
  if arr[i][j] == "W"
    arr[i][j] = "B"
  else
    arr[i][j] = "W"
  end     
end

p arr.join.count("B")

# 2

class NilClass
  def method_missing(*args); nil; end
end

class Array
  def fetch(index)
    if index < 0
      return nil
    end
    self[index]
  end
end

new_arr = Marshal.load(Marshal.dump(arr))
100.times do |day|
  i = 0
  j = 0
  while i < arr.length
    while j < arr[i].length
      adjacent_tiles = [arr.fetch(i-1).fetch(j-1), arr.fetch(i-1).fetch(j+1), arr.fetch(i).fetch(j-2), 
          arr.fetch(i).fetch(j+2), arr.fetch(i+1).fetch(j-1), arr.fetch(i+1).fetch(j+1)]

      if arr[i][j] == "B"
        if adjacent_tiles.count("B") == 0 || adjacent_tiles.count("B") > 2
          new_arr[i][j] = "W"
        end
      end

      if arr[i][j] == "W"
        if adjacent_tiles.count("B") == 2
          new_arr[i][j] = "B"
        end
      end
      j += 1
    end
    i += 1
    j = 0
  end 
  arr = Marshal.load(Marshal.dump(new_arr))
  new_arr = Marshal.load(Marshal.dump(arr))
end  

p arr.join.count("B")

