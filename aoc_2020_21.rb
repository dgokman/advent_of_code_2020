A = File.read("aoc_2020_21.txt")

require 'set'

ingredients = A.split("\n")
a = ingredients.map {|a| a.split("contains")}
foods = a.transpose.first.map {|b| b.split(" ")}.map {|a| a.map(&:strip)}.map {|a| a.reject {|b| b == "(" || b == ")"}}
allergies = a.transpose.last.map {|b| b.split(",")}.map {|a| a.map(&:strip)}.map {|a| a.map {|b| b[-1] == ")" ? b[0..-2] : b}}

@foods_hash = {}

i = 0
while i < foods.length
  foods[i].each do |food|
    @foods_hash[food] ||= Set.new
    allergies[i].each do |allergy|
      @foods_hash[food] << allergy
    end
  end
  i += 1
end

i = 0
allergies_hash = {}
while i < allergies.length
  allergies_hash[allergies[i]] ||= Set.new
  foods[i].each do |food|
    allergies_hash[allergies[i]] << food
  end 
  i += 1
end

arr = []
@cannot_have = {}
allergies_hash.each do |k,v|
  allergies_hash.each do |l,w|
    next if k == l
    if (l & k).any?
      (l & k).each do |kl|
        arr << kl
        @cannot_have[kl] ||= Set.new
        ((v+w) - (v&w)).each do |ww|
          @cannot_have[kl] << ww
        end  
      end  
    end
  end
end

def has_ingredient?(food)
  (@foods_hash[food] || []).each do |v|
    if !(@cannot_have[v] || []).include?(food)
      return true
    end
  end
  false    
end      

all_foods = @foods_hash.keys
no_ingredients = all_foods.select {|a| !has_ingredient?(a)}
count = 0
foods.each do |food|
  count += (no_ingredients & food).length
end

p count  

# 2

def has_ingredient?(food, allergy)
  !(@cannot_have[allergy] || []).include?(food)
end

can_have = {}
allergies_hash.each do |k,v|
  k.each do |allergy|
    v.each do |food|
      can_have[food] ||= Set.new
      if has_ingredient?(food, allergy)
        can_have[food] << allergy
      end
    end
  end
end

can_have = can_have.reject {|k,v| !v.any?}

new_have = {}
correct_values = {}
10.times do
  correct = []
  can_have.each do |k,v|
    if v.length == 1
      correct << [k,v]
    else
      other = v.to_a - can_have.reject {|kk,_| kk == k}.values.map(&:to_a).flatten
      if other.length == 1
        correct << [k,other]
      end
    end
  end
   
  rejects = []
  correct.each do |k,v|
    correct_values[v.first] = k
    rejects << v.first
  end  
  can_have.each do |l,w|
    new_have[l] = w.reject {|a| rejects.include?(a)}
    if l == "mnrjrf"
      new_have[l] = w.reject {|a| a == "shellfish"} # ¯\_(ツ)_/¯
    end 
  end 
  can_have = new_have.clone
end     

puts correct_values.sort.transpose.last.join(",")
