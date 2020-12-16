A = File.read("aoc_2020_16.txt")

@rules_ticket_fields, numbers_on_ticket, numbers_nearby = A.split("\n\n")

def range_headers
  @rules_ticket_fields.split("\n").map {|a| a.split(":")}.transpose[0]
end  

def ranges
  @rules_ticket_fields.split("\n")
      .map {|a| a.split(":")}.map {|a| a.last.split(" or ")}
      .map {|a| a.map {|b| b.split("-")}}
      .flatten.map(&:to_i).each_slice(2).to_a
end      

def invalid?(n)
  ranges.all? {|a,b| !n.between?(a,b) } 
end

# 1
sum = 0
numbers_nearby.split("\n").each do |row|
  sum += row.split(",").map(&:to_i).select {|a| invalid?(a)}.inject(:+).to_i
end  

p sum

# 2
valid_tickets = []
numbers_nearby.split("\n").each do |row|
  if !row.split(",").map(&:to_i).any? {|a| invalid?(a)}
    valid_tickets << row
  end
end

possible_ranges = {}
valid_tickets.map {|a| a.split(",")}.map {|a| a.map(&:to_i)}.transpose.each_with_index do |row, i|
  ranges.each_slice(2).each_with_index do |ranges_group, j|
    range1, range2 = ranges_group
    possible_ranges[i] ||= []
    if row.all? {|a| a.between?(range1.first, range1.last) || a.between?(range2.first, range2.last)}
      possible_ranges[i] << j
    end
  end
end

new_ranges = {}
correct_values = {}
until possible_ranges.all? {|k,v| v.length == 0}
  correct = possible_ranges.select {|k,v| v.length == 1}
  correct.each do |k,v|
    correct_values[k] = v
    possible_ranges.each do |l,w|
      new_ranges[l] = w.reject {|a| a == v.first}
    end 
  end
  possible_ranges = new_ranges.clone
end

mul = 1
my_ticket = numbers_on_ticket.split(",").map(&:to_i)
correct_values.each do |k,v|
  if range_headers[v.first].include?("departure")
    mul *= my_ticket[k] 
  end
end  

p mul