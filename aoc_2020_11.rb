class NilClass
  def method_missing(*args); nil; end
end

class Array
  def fetch(index)
    if index < 0
      return nil
    end
    self[index]
  end
end

A = File.read("aoc_2020_11.txt")

field = A.split("\n").map {|x| x.split("")}
new_field = Marshal.load(Marshal.dump(field))
old_count = 0
loop do
  i = 0
  j = 0
  while i < field.length
    while j < field[i].length
      adjacent_acres = [field.fetch(i-1).fetch(j-1), field.fetch(i-1).fetch(j), field.fetch(i-1).fetch(j+1), 
          field.fetch(i).fetch(j-1), field.fetch(i+1).fetch(j-1), field.fetch(i+1).fetch(j), 
          field.fetch(i+1).fetch(j+1), field.fetch(i).fetch(j+1)]

      if field[i][j] == "L"
        if adjacent_acres.count("#") == 0
          new_field[i][j] = "#"
        end
      end

      if field[i][j] == "#"
        if adjacent_acres.count("#") >= 4
          new_field[i][j] = "L"
        end
      end
      j += 1
    end
    i += 1
    j = 0
  end  

  
  field = Marshal.load(Marshal.dump(new_field))
  new_field = Marshal.load(Marshal.dump(field))
  break if field.join.count("#") == old_count
  old_count = field.join.count("#")
end

p old_count

# 2

field = A.split("\n").map {|x| x.split("")}
new_field = Marshal.load(Marshal.dump(field))
old_count = 0
loop do
  x = 0
  y = 0
  while x < field.length
    while y < field[x].length
      a,b,c,d,e,f,g,h = nil
      xx = 1
      yy = 1
      until [field.fetch(x-xx).fetch(y-yy), field.fetch(x-xx).fetch(y), field.fetch(x-xx).fetch(y+yy), 
          field.fetch(x).fetch(y-yy), field.fetch(x+xx).fetch(y-yy), field.fetch(x+xx).fetch(y), 
          field.fetch(x+xx).fetch(y+yy), field.fetch(x).fetch(y+yy)].compact.length == 0
        if !["#","L"].include?(a)
          a = field.fetch(x-xx).fetch(y-yy)
        end
        if !["#","L"].include?(b)
          b = field.fetch(x-xx).fetch(y)
        end
        if !["#","L"].include?(c)
          c = field.fetch(x-xx).fetch(y+yy)
        end
        if !["#","L"].include?(d)
          d = field.fetch(x).fetch(y-yy)
        end
        if !["#","L"].include?(e)
          e = field.fetch(x+xx).fetch(y-yy)
        end
        if !["#","L"].include?(f)
          f = field.fetch(x+xx).fetch(y)
        end
        if !["#","L"].include?(g)
          g = field.fetch(x+xx).fetch(y+yy)
        end
        if !["#","L"].include?(h)
          h = field.fetch(x).fetch(y+yy)
        end  
        xx += 1
        yy += 1
      end  

      if field[x][y] == "L"
        if [a,b,c,d,e,f,g,h].count("#") == 0
          new_field[x][y] = "#"
        end
      end

      if field[x][y] == "#"
        if [a,b,c,d,e,f,g,h].count("#") >= 5
          new_field[x][y] = "L"
        end
      end
      y += 1
    end
    x += 1
    y = 0
  end  

  
  field = Marshal.load(Marshal.dump(new_field))
  new_field = Marshal.load(Marshal.dump(field))
  break if field.join.count("#") == old_count
  old_count = field.join.count("#")
end

p old_count
