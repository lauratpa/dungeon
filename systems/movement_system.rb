class MovementSystem < System
  def initialize
    super(component_types: [Position, Roomable])
  end

  private

  def handle(player_input:, entities:)
    movement = Movement.call(player_input: player_input)
    return unless movement

    player = entities.detect do |entity|
      entity.components.map(&:type).to_set.superset?([PlayerMovable].to_set)
    end
    return unless player

    old_position = player.position
    room = player.roomable

    attributes = old_position.attributes

    coordinate = movement.fetch(:coordinate)
    value = movement.fetch(:value)
    attributes[coordinate] = attributes[coordinate] + value

    new_position = Position.new(attributes)
    occupied_positions = entities
      .tap { |ents| ents.delete(player) }
      .map { |ents| ents.position }

    return unless position_within_room?(position: new_position, room: room)
    return if hits_an_object?(position: new_position, occupied_positions: occupied_positions)

    player.replace_component(
      old_component: old_position,
      new_component: new_position
    )
  end

  def hits_an_object?(position:, occupied_positions:)
    occupied_positions.any? { |o| o.attributes == position.attributes }
  end

  def position_within_room?(position:, room:)
    (room.min_x <= position.x && position.x < room.max_x) &&
      (position.y >= room.min_y && room.max_y > position.y)
  end
end
