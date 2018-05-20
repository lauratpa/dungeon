class MovementSystem < System
  def initialize
    super(component_types: [Position, Roomable])
  end

  private

  def handle(player_input:, entities:)
    entities.each do |entity|
      movement = Movement.call(player_input: player_input)
      old_position = entity.components.detect { |c| c.type == Position }
      room = entity.components.detect { |c| c.type == Roomable }
      attributes = old_position.attributes

      coordinate = movement.fetch(:coordinate)
      value = movement.fetch(:value)
      attributes[coordinate] = attributes[coordinate] + value

      new_position = Position.new(attributes)

      return unless valid_move?(position: new_position, room: room)

      entity.replace_component(
        old_component: old_position,
        new_component: new_position
     )
    end
  end

  def valid_move?(position:, room:)
    (room.min_x <= position.x && position.x < room.max_x) &&
      (position.y >= room.min_y && room.max_y > position.y)
  end
end
