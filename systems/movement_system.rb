class MovementSystem < System
  def initialize(entity_manager:)
    super(
      component_types: [Position, Obstacle],
      entity_manager: entity_manager
    )
  end

  private

  def handle(player_input:, entities:)
    return unless player_input

    movement = Movement.call(player_input: player_input)
    return unless movement && player

    old_position = player.position
    attributes = old_position.attributes

    coordinate = movement.fetch(:coordinate)
    value = movement.fetch(:value)
    attributes[coordinate] = attributes[coordinate] + value

    new_position = Position.new(attributes)
    return if CollisionDetector.collision?(position: new_position, entities: entities)

    player.replace_component(
      old_component: old_position,
      new_component: new_position
    )
  end
end
