def setup(problem)
  a = 315679824.to_s.split("").map(&:to_i) 
  a += (10..10**6).to_a if problem == 2
  @cups = {}
  i = 0
  @start = a[i]
  while i < a.length-1
    @cups[a[i]] = a[i+1]
    i += 1
  end
  @cups[a[-1]] = a[0]
  @min = @cups.values.min
  @max = @cups.values.max
end  

def move(pointer, move, problem, goal)
  current_cup = move == 1 ? @start : pointer
  new_cup = @cups[current_cup]
  pickups = [@cups[current_cup], @cups[@cups[current_cup]], @cups[@cups[@cups[current_cup]]]]
  destination_cup = current_cup-1
  loop do
    if destination_cup < @min
      destination_cup = @max
    end 
    break if !pickups.include?(destination_cup)
    destination_cup = destination_cup-1
  end 
  
  og = @cups[destination_cup]
  hi = @cups[pickups[2]]
  @cups[destination_cup] = pickups[0]
  @cups[pickups[0]] = pickups[1]
  @cups[pickups[1]] = pickups[2]
  @cups[pickups[2]] = og
  @cups[current_cup] = hi
  if move == goal && problem == 2
    p @cups[1]*@cups[@cups[1]]  
  elsif move == goal && problem == 1
    str = ""
    z = 1
    until @cups[z] == 1
      str += @cups[z].to_s
      z = @cups[z]
    end  
    puts str
  end  
   
  hi
end

def output(goal, problem)
  setup(problem)
  i = 0
  goal.times do |n|
    i = move(i, n+1, problem, goal)
  end 
end   

# 1


output(100, 1)

# 2

output(10**7, 2)