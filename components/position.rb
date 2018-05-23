class Position < Component
  attr_reader :x, :y

  def initialize(x:, y:)
    @x = x
    @y = y
  end

  def attributes
    { x: x, y: y }
  end
end
