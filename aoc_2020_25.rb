C = 11349501
D = 5107328

def transform(subject, loop_size=nil)
  a = 1
  (loop_size || 10**10).times do |j|
    a *= subject
    a %= 20201227
    if !loop_size && a == C
      return j+1
    end  
  end
  a
end  

p transform(D,transform(7))
