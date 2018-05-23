class MovementSystem < System
  def initialize
    super(component_types: [Position, Roomable])
  end

  private

  def handle(player_input:, entities:)
    movement = Movement.call(player_input: player_input)
    return unless movement

    entities.each do |entity|
      old_position = entity.position
      room = entity.roomable

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
