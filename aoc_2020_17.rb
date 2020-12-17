require 'set'

A = "..#..#..
.###..#.
#..##.#.
#.#.#.#.
.#..###.
.....#..
#...####
##....#."

possibles = []
L = 15

for x in -L..L
  for y in -L..L
    for z in -8..8
      possibles << [x,y,z]
    end
  end
end      

def active_neighbors(x,y,z,arr)
  count = 0
  [-1,0,1].each do |a|
    [-1,0,1].each do |b|
      [-1,0,1].each do |c|
        next if [a,b,c] == [0,0,0]
        if arr.include?([x+a,b+y,c+z])
          count += 1
        end
      end
    end
  end
  count
end          

y = 0
x = 0


field = A.split("\n").map {|x| x.split("")}
actives = Set.new
while y < field.length
  while x < field[y].length
    if field[y][x] == "#"
      actives << [x,y,0]
    end  
    x += 1
  end
  y += 1
  x = 0
end   

6.times do
  new_actives = []
  possibles.each_with_index do |(x,y,z), idx|
    active_neighbors = active_neighbors(x,y,z,actives)
    if actives.include?([x,y,z]) 
      if [2,3].include?(active_neighbors)
        new_actives << [x,y,z]
      end
    else  
      if active_neighbors == 3
        new_actives << [x,y,z]
      end  
    end
  end   
  actives = new_actives.to_set
end  
  
p actives.length

  
# 2

possibles = []
for x in -L..L
  for y in -L..L
    for z in -8..8
      for w in -8..8
        possibles << [x,y,z,w]
      end  
    end
  end
end      

def active_neighbors(x,y,z,w,arr)
  count = 0
  [-1,0,1].each do |a|
    [-1,0,1].each do |b|
      [-1,0,1].each do |c|
        [-1,0,1].each do |d|
          next if [a,b,c,d] == [0,0,0,0]
          if arr.include?([x+a,b+y,c+z,d+w])
            count += 1
          end
        end  
      end
    end
  end
  count
end          

y = 0
x = 0

field = A.split("\n").map {|x| x.split("")}
actives = Set.new
while y < field.length
  while x < field[y].length
    if field[y][x] == "#"
      actives << [x,y,0,0]
    end  
    x += 1
  end
  y += 1
  x = 0
end   

6.times do
  new_actives = []
  possibles.each_with_index do |(x,y,z,w), idx|
    active_neighbors = active_neighbors(x,y,z,w,actives)
    if actives.include?([x,y,z,w]) 
      if [2,3].include?(active_neighbors)
        new_actives << [x,y,z,w]
      end
    else  
      if active_neighbors == 3
        new_actives << [x,y,z,w]
      end  
    end
  end   
  actives = new_actives.to_set
end  
  
p actives.length
