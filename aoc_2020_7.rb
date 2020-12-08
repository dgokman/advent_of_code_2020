A = File.read("aoc_2020_7.txt")

# 1

def doit(graph, start)
  return [] unless graph.key?(start)
  recurse(graph, start).drop(1)
end

def recurse(graph, start)
  if (0..9).to_a.map(&:to_s).include?(start[0])
    start = start[2..-1]
  end  
  (graph[start] || []).each_with_object([[start]]) { |next_node, arr|
    recurse(graph, next_node).each { |a| arr << [start, *a] } }
end

arr = A.split("\n").map {|a| a.split("contain")}.map {|a| a.map {|b| b.strip}}

@hash = {}
arr.each do |rule|
  rule[1].split(",").each do |subrule|
    bag = rule[0][-1] == "s" ? rule[0][0..-2] : rule[0]
    @hash[bag] ||= []
    @hash[bag] << subrule.split(" ").map {|a| a[-1] == "." ? a[0..-2] : a}
     .map {|a| a[-1] == "s" ? a[0..-2] : a}.join(" ")
  end
end

count = 0
goal = "shiny gold"
@hash.keys.each do |key|
  next if key.include?(goal)
  if doit(@hash, key).any? {|a| a.last.include?(goal)}
    count += 1
  end  
end  

p count

# 2

@count = 0

def count_bags(times, key)
  times.times do
    @count += 1
    @hash[key].each do |key|
      times = key[0].to_i
      key = key[2..-1]
      count_bags(times, key)
    end
  end
end

count_bags(1, "shiny gold bag")
p @count-1        
      

  
