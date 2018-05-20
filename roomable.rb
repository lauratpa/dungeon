require './component'

class Roomable < Component
  attr_reader :min_x, :max_x, :min_y, :max_y

  def initialize(min_x:, min_y:, max_x:, max_y:)
    @min_x = min_x
    @min_y = min_y
    @max_x = max_x
    @max_y = max_y
  end
end
