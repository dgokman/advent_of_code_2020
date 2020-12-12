A = File.read("aoc_2020_12.txt")

dirs = A.split("\n").map {|a| [a[0],a[1..-1].to_i]}

@dir_hash90 = {"E"=>"S", "S"=>"W", "W"=>"N", "N"=>"E"}
@dir_hash180 = {"E"=>"W", "S"=>"N", "W"=>"E", "N"=>"S"}
@dir_hash270 = {"E"=>"N", "S"=>"E", "W"=>"S", "N"=>"W"}
@operators = {"E"=>"+=", "S"=>"-=", "W"=>"-=", "N"=>"+="}

def move(dir, val, ew, ns, current_dir)
  case dir
  when "F"
    eval("#{["ew", "ns"].find {|a| a.upcase.include?(current_dir)}}#{@operators[current_dir]}#{val}")
  when "N", "S", "E", "W"
    eval(("#{["ew", "ns"].find {|a| a.upcase.include?(dir)}}#{@operators[dir]}#{val}"))
  when "R", "L"
    current_dir = instance_variable_get("@dir_hash#{((dir == "R" ? 0 : 360) - val).abs}")[current_dir]
  end
  [ew, ns, current_dir]
end  

ew, ns, current_dir = 0, 0, "E"
dirs.each do |dir, val|
  ew, ns, current_dir = move(dir, val, ew, ns, current_dir)
end  

p ew.abs + ns.abs

def move_with_waypoint(dir, val, ew, ns, current_dir1, current_dir2, wp1, wp2)
  update_dir = ->(dir1, dir2) do
    [dir1, dir2].include?(current_dir1) ? (current_dir1 == dir1 ? wp1 += val : wp1 -= val) : (current_dir2 == dir1 ? wp2 += val : wp2 -= val)
    (wp1 < 0 ? current_dir1 = current_dir1 == dir1 ? dir2 : dir1 : current_dir2 = current_dir2 == dir1 ? dir2 : dir1) if wp1 < 0 || wp2 < 0
    wp1, wp2 = wp1.abs, wp2.abs
  end
  case dir
  when "F"
    [1,2].each do |nn|
      current_dir = eval("current_dir#{nn}")
      wp = eval("wp#{nn}")
      eval("#{["ew", "ns"].find {|a| a.upcase.include?(current_dir)}}#{@operators[current_dir]}#{val*wp}")
    end
  when "N", "S", "E", "W"
    update_dir.call(dir, @dir_hash180[dir])
  when "R", "L"
    current_dir1 = instance_variable_get("@dir_hash#{((dir == "R" ? 0 : 360) - val).abs}")[current_dir1]
    current_dir2 = instance_variable_get("@dir_hash#{((dir == "R" ? 0 : 360) - val).abs}")[current_dir2]
  end    
  [ew, ns, current_dir1, current_dir2, wp1, wp2]
end

ew, ns, current_dir1, current_dir2, wp1, wp2 = 0, 0, "E", "N", 10, 1
dirs.each do |dir, val|
  ew, ns, current_dir1, current_dir2, wp1, wp2 = move_with_waypoint(dir, val, ew, ns, current_dir1, current_dir2, wp1, wp2)
end

p ew.abs + ns.abs
