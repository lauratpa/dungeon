class CollisionDetector
  def self.collision?(entities:, position:)
    entities.any? { |e| e.position == position }
  end

  def self.within_boundaries?(room:, position:)
    (room.min_x <= position.x && position.x < room.max_x) &&
      (position.y >= room.min_y && room.max_y > position.y)
  end
end
