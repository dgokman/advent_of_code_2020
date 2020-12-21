A = File.read("aoc_2020_19.txt")

# 1

require 'set'

@count = Set.new

def add_to_string(rules, arr)
  clon = arr.clone
  arr = []
  rules.each do |rule| 
    if @rules[rule.to_i].include?("a")
      if clon.any?
        clon.map! {|a| a + "a"}

      else
        clon << "a"
      end    
    elsif @rules[rule.to_i].include?("b")
      if clon.any?
        clon.map! {|a| a + "b"}
      else
        clon << "b"
      end    
    else 
      _, rules = @rules[rule.to_i].split(":")
      rules = rules.split(" ").map(&:strip)
      if rules.include?("|")
        if rules.length == 7
          middle = 2
        else  
          middle = rules.length.odd? ? rules.length/2 : rules.length/2-1
        end  
        clon1 = add_to_string(rules[0..middle-1], clon)
        clon2 = add_to_string(rules[middle+1..-1], clon)
        clon = clon1 + clon2
      else
        clon = add_to_string(rules[0..-1],clon) 
      end  
    end
  end 
  return clon
end  

def count_messages(arr)
  @messages.each do |a|
    if arr.include?(a)
      @count << a
    end
  end  
end


rules, @messages = A.split("\n\n").map {|a| a.split("\n")}
rules = rules.map {|rule| no, _ = rule.split(":"); [no.to_i, rule]}
@rules = []
rules.each do |idx,rule|
  @rules[idx] = rule
end  

arr = []
arr = add_to_string(@rules[0].split(":").last.split(" ").map(&:strip),arr).to_set

count_messages(arr) 
p @count.length

# 2

arr = []
@arr_42 = add_to_string([42], arr)
arr = []
@arr_31 = add_to_string([31], arr)

L = @arr_42.first.length
M = @arr_31.first.length

def valid_42(message)
  i = 0
  message.split("").each_slice(L).each do |slice|
    if @arr_42.include?(slice.join)
      i += 1
    else
      return i
    end
  end
end       

def valid_31(message, i)
  j = 0
  return false if message[i*L..-1].length < M
  message[i*L..-1].split("").each_slice(M).each do |slice|
    if !@arr_31.include?(slice.join)
      return false
    else
      j += 1
    end  
  end
  j
end 

@messages.each do |message|
  i = valid_42(message)
  next unless i.to_i > 1
  j = valid_31(message, i)
  if j && j < i
    @count << message
  end
end

p @count.length