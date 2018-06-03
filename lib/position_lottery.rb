class PositionLottery
  def initialize(entity_manager:)
    @entity_manager = entity_manager
  end

  def draw(room:)
    selected_entities = entity_manager.
      select(component_types: [Roomable]).
      select { |ent| ent.roomable == room }

    loop do
      position = random_position_in(room)
      break position unless CollisionDetector.collision?(entities: selected_entities, position: position)
    end
  end

  private

  attr_reader :entity_manager

  def random_position_in(room)
    x = (room.min_x...room.max_x).to_a.sample
    y = (room.min_y...room.max_y).to_a.sample

    Position.new(x: x, y: y)
  end
end
