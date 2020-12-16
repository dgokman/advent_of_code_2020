A = "0,1,5,10,3,12,19"
nums = A.split(",").map(&:to_i)

def setup(nums)
  @last = {}
  nums.each_with_index do |a,i|
    @last[a] = i
  end  

  @so_far = nums.clone[0..-2]
  @counter = @so_far.length-1
end

def rules(n)
  @counter += 1
  if !@last[n]
    @so_far << n
    @last[n] = @counter
    return 0
  else
    turns = @counter - @last[n]
    @last[n] = @counter
    @so_far << n  
    return turns
  end
end  

[2020, 3*10**7].each do |l|
  setup(nums)
  turns = []
  turn = rules(nums.last)  
  (l-@last.length).times do |n|
    turn = rules(turn)
  end 
  p @so_far.last
end



