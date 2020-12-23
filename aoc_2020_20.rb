A = File.read("aoc_2020_20.txt")

def rotate(o)
  rows, cols = o.size, o[0].size
  Array.new(cols){|i| Array.new(rows){|j| o[j][cols - i - 1]}}
end

def get_border_coordinates(tile)
  coords = []
  borders = [tile.first, tile.last, tile.map {|a| a.first}, tile.map {|a| a.last}]
  borders.each do |border|
    i = 0
    sub_coords = []
    while i < border.length
      if border[i] == "#"
        sub_coords << i
      end
      i += 1
    end
    coords << sub_coords
    coords << sub_coords.map {|a| 9-a}.sort
  end  
  coords
end  

# 1
coords = {}   

tiles = A.split("\n\n")
tiles_with_id = {}
tiles.each do |tile|
  tile = tile.split("\n")
  tiles_with_id[tile.first.split(" ").last.to_i] = tile[1..-1].map {|a| a.split("")}
end   

tiles_with_id.each do |k,v|
  coords[k] = get_border_coordinates(v)
end

all_coords = []
coords.values.each do |a|
  a.each do |b|
    all_coords << b
  end  
end  

corners = 1
sides = {}
coords.each do |k,v|
  if v.select {|a| all_coords.count(a) > 1}.count == 4
    corners *= k
  end  
end

p corners   

# 2

require 'set'

# find connections for each tile
connections = {}
coords.each do |k,v|
  connections[k] ||= Set.new
  coords.each do |l,w|
    connections[l] ||= Set.new
    if (v & w).any?
      connections[k] << l unless k == l
      connections[l] << k unless k == l
    end
  end
end

hw = Math.sqrt(connections.length).to_i

# code to output edges using Mathematica Graph function
edges = []  
connections.each do |k,v|
  v.each do |w|
    edges << "#{k} <-> #{w}"
  end
end

# Graph[edges.to_s.gsub("\""," ").gsub("[","{").gsub("]","}")]

# Taken from Mathematica output
# advent_of_code_20_tiles.pdf
edges = [
  3539, 2357, 2341, 1709, 3229, 2803, 1373, 1823, 2239, 1933, 1553, 2693, 
  2719, 3769, 2293, 3457, 2029, 1783, 1861, 2687, 1657, 2579, 1163, 1571, 
  2953, 3673, 2767, 3617, 2081, 3467, 1153, 2851, 2503, 2399, 1801, 2543, 
  1523, 2939, 1741, 1543, 1033, 3623, 1061, 1307, 3631, 1129, 1381, 3853, 
  2789, 3761, 2287, 1669, 1361, 1721, 1597, 2887, 3391, 3089, 1627, 2833, 
  3019, 2549, 2333, 1367, 3209, 3313, 3851, 2539, 2111, 3821, 3541, 2393, 
  1249, 1667, 1291, 2389, 2003, 2383, 1877, 2909, 2351, 3833, 3389, 1901, 
  1237, 3359, 3571, 3413, 2677, 3323, 2113, 1979, 1999, 1103, 3677, 2897, 
  1229, 1193, 1493, 3931, 2267, 2411, 1399, 3083, 3637, 3319, 3929, 2917, 
  3943, 3881, 1579, 2203, 1697, 3187, 1123, 3907, 2153, 1289, 1723, 3797, 
  3203, 2731, 3967, 1993, 1487, 3331, 2143, 1931, 2273, 3889, 3329, 1297, 
  3709, 1409, 2347, 3061, 2689, 2011, 3121, 1279, 2089, 2437, 3779, 1549
]

# rotate and flip until match is found
def tiles_match(arr)
  new_arr = []
  a = arr[0]
  b = arr[1]
  4.times do
    a = rotate(a)
    4.times do 
      b = rotate(b)
      if a.last == b.first
        new_arr[0] = a
        new_arr[1] = b
      end
      b = b.map {|c| c.reverse}
      if a.last == b.first
        new_arr[0] = a
        new_arr[1] = b
      end
      b = b.map {|c| c.reverse}
    end
    a = a.map {|c| c.reverse}
    b = arr[1]
    4.times do 
      b = rotate(b)
      if a.last == b.first
        new_arr[0] = a
        new_arr[1] = b
      end
      b = b.map {|c| c.reverse}
      if a.last == b.first
        new_arr[0] = a
        new_arr[1] = b
      end
      b = b.map {|c| c.reverse}
    end
    a = a.map {|c| c.reverse}
  end
  
  for i in 2..arr.length-1
    a = new_arr[i-1]
    b = arr[i]
    4.times do 
      b = rotate(b)
      if a.last == b.first
        new_arr[i] = b
      end
      b = b.map {|c| c.reverse}
      if a.last == b.first
        new_arr[i] = b
      end
      b = b.map {|c| c.reverse}
    end
  end  
  new_arr
end          

# match tiles foe each column
columns = []
edges.each_slice(hw).to_a.transpose.each do |cols|
  tiles_match(cols.map {|a| tiles_with_id[a]}).each do |a|
    columns << a
  end  
end  

# join columns
columns_hash = {}
i = 0
columns.each do |c|
  c.each do |d|
    columns_hash[i / (hw*10)] ||= []
    columns_hash[i / (hw*10)] << d
    i += 1
  end
end    

# match columns by row
columns_hash_with_direction = {}
for i in 0..hw-2
  if columns_hash[i].map {|a| a.last} == columns_hash[i+1].map {|a| a.first}
    columns_hash_with_direction[i] = columns_hash[i]
    columns_hash_with_direction[i+1] = columns_hash[i+1]
  elsif columns_hash[i].map {|a| a.last} == columns_hash[i+1].map {|a| a.reverse}.map {|a| a.first}  
    columns_hash_with_direction[i] = columns_hash[i]
    columns_hash_with_direction[i+1] = columns_hash[i+1].map {|a| a.reverse}
  elsif columns_hash[i].map {|a| a.reverse}.map {|a| a.last} == columns_hash[i+1].map {|a| a.first}
    columns_hash_with_direction[i] = columns_hash[i].map {|a| a.reverse}
    columns_hash_with_direction[i+1] = columns_hash[i+1]
  else
    columns_hash_with_direction[i] = columns_hash[i].map {|a| a.reverse}
    columns_hash_with_direction[i+1] = columns_hash[i+1].map {|a| a.reverse}
  end
end

# find borders to remove
border_idx = []
k = 0
hw.times do
  border_idx << k
  border_idx << k+9
  k += 10
end  

# remove borders
columns_without_borders = []
columns_hash_with_direction.each do |k,v|
  v = v.each_with_index.reject {|b,i| border_idx.include?(i)}.map {|a| a.first}
  new_v = []
  v.each do |w|
    new_v << w[1..-2]
  end
  columns_without_borders << new_v
end    

# build image
image = []
for i in 0..hw*8-1
  image << (0..hw-1).to_a.map {|j| columns_without_borders[j][i]}.inject(:+)
end     
    
sea_monster = "                  # 
#    ##    ##    ###
 #  #  #  #  #  #   ".split("\n").join
sea_monster_idxs = []

# find sea monster indices
i = 0
while i < sea_monster.length
  if sea_monster[i] == "#"
    sea_monster_idxs << i
  end
  i += 1
end

# find sea monsters
monsters = 0
4.times do
  image = rotate(image)
  i = 0
  j = 0
  while i < image.length-2
    while j < image[i].length-19
      str = image[i..i+2].map {|o| o[j..j+19]}.join
      if sea_monster_idxs.all? {|a| str[a] == "#"}
        monsters += 1
      end
      j += 1
    end
    i += 1
    j = 0
  end
  image = image.map {|c| c.reverse}  
  i = 0
  j = 0
  while i < image.length-2
    while j < image[i].length-19
      str = image[i..i+2].map {|o| o[j..j+19]}.join
      if sea_monster_idxs.all? {|a| str[a] == "#"}
        monsters += 1
      end
      j += 1
    end
    i += 1
    j = 0
  end 
  image = image.map {|c| c.reverse}
end

p image.join.count("#") - monsters*sea_monster_idxs.length

