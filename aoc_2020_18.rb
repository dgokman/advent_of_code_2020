exprs = File.read("aoc_2020_18.txt").split("\n")

# 1

class Fixnum
  def <<(x)
    self * x
  end

  def >>(x)
    self + x  
  end
end

p exprs.map {|exp| eval(exp.gsub("*","<<").gsub("+",">>"))}.inject(:+)

# 2

class Fixnum
  def -(x)
    self * x
  end

  def /(x)
    self + x  
  end
end

p exprs.map {|exp| eval(exp.gsub("*","-").gsub("+","/"))}.inject(:+)