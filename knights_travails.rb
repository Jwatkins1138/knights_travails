class Knight

  attr_accessor :position, :move_a, :move_b, :move_c, :move_d, :move_e, :move_f, :move_g, :move_h, :paths

  def initialize(position)
    @position = position
    @move_a = nil
    @move_b = nil
    @move_c = nil
    @move_d = nil
    @move_e = nil
    @move_f = nil
    @move_g = nil
    @move_h = nil
  end

  def value
    return @value
  end

  def paths
    return @paths
  end

  def move_a
    return @move_a
  end

  def move_b
    return @move_b
  end

  def move_c
    return @move_c
  end

  def move_d
    return @move_d
  end

  def move_e
    return @move_e
  end

  def move_f
    return @move_f
  end

  def move_g
    return @move_g
  end

  def move_h
    return @move_h
  end

  def moves_array
    moves = Array.new
    if @move_a != nil
      moves.push(@move_a.position) 
    end  
    if @move_b != nil
      moves.push(@move_b.position) 
    end
    if @move_c != nil
      moves.push(@move_c.position) 
    end
    if @move_d != nil
      moves.push(@move_d.position)
    end 
    if @move_e != nil
      moves.push(@move_e.position) 
    end
    if @move_f != nil
      moves.push(@move_f.position) 
    end
    if @move_g != nil
      moves.push(@move_g.position)
    end 
    if @move_h != nil
      moves.push(@move_h.position) 
    end
    moves   
  end

  def moves_array_obj
    moves = Array.new
    if @move_a != nil
      moves.push(@move_a) 
    end  
    if @move_b != nil
      moves.push(@move_b) 
    end
    if @move_c != nil
      moves.push(@move_c) 
    end
    if @move_d != nil
      moves.push(@move_d)
    end 
    if @move_e != nil
      moves.push(@move_e) 
    end
    if @move_f != nil
      moves.push(@move_f) 
    end
    if @move_g != nil
      moves.push(@move_g)
    end 
    if @move_h != nil
      moves.push(@move_h) 
    end
    moves   
  end

  def calculate_moves
   
    @move_a = Knight.new([@position[0] - 1, @position[1] + 2])
    @move_b = Knight.new([@position[0] - 2, @position[1] + 1])
    @move_c = Knight.new([@position[0] - 2, @position[1] - 1])
    @move_d = Knight.new([@position[0] - 1, @position[1] - 2])
    @move_e = Knight.new([@position[0] + 1, @position[1] + 2])
    @move_f = Knight.new([@position[0] + 2, @position[1] + 1])
    @move_g = Knight.new([@position[0] + 1, @position[1] - 2])
    @move_h = Knight.new([@position[0] + 2, @position[1] - 1])
    unless self.is_valid(@move_a.position)
      @move_a = nil
    end
    unless self.is_valid(@move_b.position)
      @move_b = nil
    end
    unless self.is_valid(@move_c.position)
      @move_c = nil
    end
    unless self.is_valid(@move_d.position)
      @move_d = nil
    end
    unless self.is_valid(@move_e.position)
      @move_e = nil
    end
    unless self.is_valid(@move_f.position)
      @move_f = nil
    end
    unless self.is_valid(@move_g.position)
      @move_g = nil
    end
    unless self.is_valid(@move_h.position)
      @move_h = nil
    end
  end

  def find_path(value, moves = @potential_moves, position = @value)
    p "value #{value} moves #{moves_array(moves)}"
    p "position #{position}"
    if moves_array(moves).include?(value)
      @path.push(value)
      p "path #{@path}"
      @paths.push(@path)
      p "paths #{@paths}"
      @path = [@value]
      p "reset path #{@path}"
      position = @value
    else
      moves.each { |k|
        unless @path.include?(k.value)
          p "enum path #{@path}"
          p "enum posi #{position}"
          k.calculate_moves(k.value)
          @path.push(k.value)
          find_path(value, k.potential_moves, k.value)
        end
      }
    end
  end

  def calculate_paths(value, position = @value)
    if moves_array.include?(value)
      return
    else
      i = 0
      while i < self.potential_moves.length
      end
    end
  end

  def find_shortest
    while @paths.length > 1
      if @paths[0].length > @paths[1].length
        @paths.delete_at(0)
      else
        @paths.delete_at(1)
      end
    end
  end

  def knight_move(value, move = @potential_moves, path = [@value], best_path = [@value])
    p moves_array(move)
    
    
    if moves_array(move).include?(value)
      path.push(value)
      if path.length < best_path.length || (best_path.length == 1 && path.length > 1)
        best_path = path
      else
        path = [@value]
      end
      return
    else
      i = 0
      while i < move.length
        k = move[i]
        unless path.include?(k.value)
          p "path #{path}"
          p "k val #{k.value}"
          k.calculate_moves(k.value)
          path.push(k.value)
          knight_move(value, k.potential_moves, path, best_path)  
          i += 1
        end
      end
    end
  end

  def is_valid(value)
    if (0..7).include?(value[0]) && (0..7).include?(value[1])
      return true
    else
      return false
    end
  end

end

class Board
  attr_accessor :current

  def initialize(position)
    @current = Knight.new(position)

  end

  def current
    @current
  end

  def find_paths(position, knight = @current, path = Array.new, best_path = Array.new)
    knight.calculate_moves
    p "knight #{knight.position}"
    p "path #{path}"
    p "best path #{best_path}"
    p "position #{position}"
    p "moves #{knight.moves_array}"
    if knight.moves_array.include?(position)
      path.push(position)
      if best_path.empty? || path.length < best_path.length
        best_path = path
      end
      path = []
    end
    if knight.move_a
      unless path.include?(knight.move_a.position)
        path.push(knight.position)
        find_paths(position, knight.move_a, path, best_path)
      end
    end
    if knight.move_b
      unless path.include?(knight.move_b.position)
      path.push(knight.position)
      find_paths(position, knight.move_b, path, best_path)
      end
    end
    if knight.move_c
      unless path.include?(knight.move_c.position)
      path.push(knight.position)
      find_paths(position, knight.move_c, path, best_path)
      end
    end
    if knight.move_d
      unless path.include?(knight.move_d.position)
      path.push(knight.position)
      find_paths(position, knight.move_d, path, best_path)
      end
    end
    if knight.move_e
      unless path.include?(knight.move_e.position)
      path.push(knight.position)
      find_paths(position, knight.move_e, path, best_path)
      end
    end
    if knight.move_f
      unless path.include?(knight.move_f.position)
      path.push(knight.position)
      find_paths(position, knight.move_f, path, best_path)
      end
    end
    if knight.move_g
      unless path.include?(knight.move_g.position)
      path.push(knight.position)
      find_paths(position, knight.move_g, path, best_path)
      end
    end
    if knight.move_h
      unless path.include?(knight.move_h.position)
        path.push(knight.position)
        find_paths(position, knight.move_h, path, best_path)
      end
    end  
    best_path
  end

  def level_order_search(destination, &block)
    not_found = true
    que = Array.new
    que.push(@current)
    while not_found
        que[0].calculate_moves
        que[0].moves_array_obj.each {|x| que.push(x)}
        yield que[0]
      if que[0].position == destination
        not_found = false
        return
      end
      que.shift
    end
  end

  def find_path(destination)
    output = Array.new
    positions = []
    level_order_search(destination) { |x|
      output.unshift(x)
      }
    i = 1
    while i < output.length
      if output[i].moves_array.include?(output[i-1].position)
        i += 1
      else
        output.delete_at(i)
      end
    end
    output.map { |x| x.position}
  end

  def knight_move(start, destination)
    @current = Knight.new(start)
    path = find_path(destination)
    if path.length < 2
      p "Knight moves from #{start} to #{destination} in #{path.length - 1} move."
    else 
      p "Knight moves from #{start} to #{destination} in #{path.length - 1} moves."
    end
    i = path.length - 1
    while i > 0
      p "Knight moves from #{path[i]} to #{path[i-1]}."
      i -= 1
    end

  end

end


board = Board.new([4, 4])

board.knight_move([5, 2], [3, 3])
board.knight_move([4, 4], [7, 7])
board.knight_move([0, 0], [7, 7])

