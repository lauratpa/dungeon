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

  def self.add_components_to(entity:, x:, y:, path:)
    entity.add_component(Obstacle.new)
    entity.add_component(Position.new(x: x, y: y))
    entity.add_component(Presentable.new(path: path))
    entity.add_component(GameImage.new(path: path))
  end

  def self.top_left_corner(x:, y:)
    path = './data/top_left_corner.png' # Should be in config
    Entity.new.tap { |entity| add_components_to(entity: entity, x: x, y: y, path: path) }
  end

  def self.top_right_corner(x:, y:)
    path = './data/top_right_corner.png'
    Entity.new.tap { |entity| add_components_to(entity: entity, x: x, y: y, path: path) }
  end

  def self.top(x:, y:)
    path = './data/top.png'
    Entity.new.tap { |entity| add_components_to(entity: entity, x: x, y: y, path: path) }
  end

  def self.bottom_left_corner(x:, y:)
    path = './data/bottom_left_corner.png'
    Entity.new.tap { |entity| add_components_to(entity: entity, x: x, y: y, path: path) }
  end

  def self.bottom_right_corner(x:, y:)
    path = './data/bottom_right_corner.png'
    Entity.new.tap { |entity| add_components_to(entity: entity, x: x, y: y, path: path) }
  end

  def self.bottom(x:, y:)
    path = './data/bottom.png'
    Entity.new.tap { |entity| add_components_to(entity: entity, x: x, y: y, path: path) }
  end

  def self.left_wall(x:, y:)
    path = './data/left.png'
    Entity.new.tap { |entity| add_components_to(entity: entity, x: x, y: y, path: path) }
  end

  def self.right_wall(x:, y:)
    path = './data/right.png'
    Entity.new.tap { |entity| add_components_to(entity: entity, x: x, y: y, path: path) }
  end

  def self.bricks(x:, y:)
    path =  './data/bricks1.png'
    Entity.new.tap { |entity| add_components_to(entity: entity, x: x, y: y, path: path) }
  end

  def self.floor(x:, y:)
    Entity.new.tap do |entity|
      entity.add_component(Position.new(x: x, y: y))
      entity.add_component(GameImage.new(path: './data/floor1.png'))
    end
  end
end
