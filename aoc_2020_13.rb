A = File.read("aoc_2020_13.txt").split("\n")

orig_goal = A[0].to_i

buses = A[1].split(",").map(&:to_i)
real_buses = buses.reject {|a| a == 0}

goal = orig_goal
until real_buses.select {|a| goal % a.to_i == 0}.any?
  goal += 1
end

p real_buses.select {|a| goal % a.to_i == 0}.first * (goal-orig_goal)

# 2

# https://rosettacode.org/wiki/Chinese_remainder_theorem#Ruby
def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient*x, x
    y, last_y = last_y - quotient*y, y
  end
  return last_remainder, last_x * (a < 0 ? -1 : 1)
end
 
def invmod(e, et)
  g, x = extended_gcd(e, et)
  if g != 1
    raise 'Multiplicative inverse modulo does not exist!'
  end
  x % et
end
 
def chinese_remainder(mods, remainders)
  max = mods.inject( :* )  # product of all moduli
  series = remainders.zip(mods).map{ |r,m| (r * max * invmod(max/m, m) / m) }
  series.inject( :+ ) % max 
end

mods = []
ids = []
buses.each_with_index.map {|a,i| [a,i]}.each do |a,i|
  mods << a if a != 0
  ids << a-i if a != 0
end

p chinese_remainder(mods, ids)


