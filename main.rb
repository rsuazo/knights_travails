class Square
  attr_accessor :x, :y, :parent_obj
  @@route = []

  def initialize(x, y, parent_obj = nil)
    @y, @x = y, x
    @parent_obj = parent_obj
  end

  def ==(obj)
    @y == obj.y && @x == obj.x 
  end

  def valid?
    (0..7) === @x && (0..7) === @y
  end

  def to_s
    %w(a b c d e f g h)[@x] + %w(1 2 3 4 5 6 7 8)[@y] if valid?
  end

  def generate_moves
    a = Square.new(@x - 1, @y + 2, self)
    b = Square.new(@x + 1, @y + 2, self)
    c = Square.new(@x - 1, @y - 2, self)
    d = Square.new(@x + 1, @y - 2, self)
    e = Square.new(@x + 2, @y + 1, self)
    f = Square.new(@x + 2, @y - 1, self)
    g = Square.new(@x - 2, @y + 1, self)
    h = Square.new(@x - 2, @y - 1, self)

    list = [a,b,c,d,e,f,g,h]
    
    list.reject! { |item| !item.valid?}

    list
  end

  def breadth_first_search(start, finish)
    
    return false if !start.valid? || !finish.valid?

    queue = []
    queue << start


    while !queue.empty? do
      current_node = queue.shift

      if current_node == finish
        return current_node
      else
        new_moves = current_node.generate_moves
        new_moves.each {|item| queue << item}
      end
    end

  end

  def knight_moves(start, finish)

    result = breadth_first_search(start, finish)

    route = []
    route.unshift(finish)
    current = result.parent_obj
    until current.nil?
      route.unshift(current)
      current = current.parent_obj
    end
    puts "You made it in #{route.length - 1} moves! Here's your path:"
    route.each { |square| puts square}
    return nil
  end
end

start = Square.new(7,7)
finish = Square.new(0,0)

start.knight_moves(start, finish)


## credits:
## John Quarles via his blog: https://qdevdive.blogspot.com/search?q=chess
## Matthew Moss via Ruby Quiz: http://rubyquiz.com/quiz27.html
## Scott Bobbitt & @Spike via: https://codereview.stackexchange.com/questions/110256/knights-travails-in-ruby