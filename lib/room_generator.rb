class RoomGenerator
  def self.call(x:, y:, width:, height:)
    height.times.with_object([]) do |i, entities|
      y_position = y + i
      x_positions = width.times.map { |i| x + i }
      case i
      when 0
        entities << top_left_corner(y: y_position, x: x_positions.first)
        x_positions[1...-1].each do |x_position|
          entities << top(y: y_position, x: x_position)
        end
        entities << top_right_corner(y: y_position, x: x_positions.last)
      when 1
        entities << left_wall(y: y_position, x: x_positions.first)
        x_positions[1...-1].each do |x_position|
          entities << bricks(y: y_position, x: x_position)
        end
        entities << right_wall(y: y_position, x: x_positions.last)
      when height - 1
        entities << bottom_left_corner(y: y_position, x: x_positions.first)
        x_positions[1...-1].each do |x_position|
          entities << bottom(y: y_position, x: x_position)
        end
        entities << bottom_right_corner(y: y_position, x: x_positions.last)
      else
        entities << left_wall(y: y_position, x: x_positions.first)
        x_positions[1...-1].each do |x_position|
          entities << floor(y: y_position, x: x_position)
        end
        entities << right_wall(y: y_position, x: x_positions.last)

      end
    end
  end

  private

  attr_reader :world

  def self.top_left_corner(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Obstacle.new)
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(Presentable.new(path: './data/top_left_corner.png'))
    end
  end

  def self.top_right_corner(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Obstacle.new)
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(Presentable.new(path: './data/top_right_corner.png'))
    end
  end

  def self.top(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Obstacle.new)
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(Presentable.new(path: './data/top.png'))
    end
  end

  def self.bottom_left_corner(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Obstacle.new)
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(Presentable.new(path: './data/bottom_left_corner.png'))
    end
  end

  def self.bottom_right_corner(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Obstacle.new)
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(Presentable.new(path: './data/bottom_right_corner.png'))
    end
  end

  def self.bottom(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Obstacle.new)
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(Presentable.new(path: './data/bottom.png'))
    end
  end

  def self.left_wall(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Obstacle.new)
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(Presentable.new(path: './data/left.png'))
    end
  end

  def self.right_wall(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Obstacle.new)
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(Presentable.new(path: './data/right.png'))
    end
  end

  def self.bricks(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Obstacle.new)
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(Presentable.new(path: './data/bricks1.png'))
    end
  end

  def self.floor(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(Presentable.new(path: './data/floor1.png'))
    end
  end
end
