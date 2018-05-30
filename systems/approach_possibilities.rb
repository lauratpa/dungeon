class ApproachPossibilities
  def self.call(to_position:, from_position:)
    y_distance = to_position.y - from_position.y
    x_distance = to_position.x - from_position.x

    [].tap do |positions|
      positions << Position.new(x: from_position.x, y: from_position.y - 1) if y_distance < 0
      positions << Position.new(x: from_position.x, y: from_position.y + 1) if y_distance > 0

      positions << Position.new(x: from_position.x - 1, y: from_position.y) if x_distance < 0
      positions << Position.new(x: from_position.x + 1, y: from_position.y) if x_distance > 0
    end
  end
end
