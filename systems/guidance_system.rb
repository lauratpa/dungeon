class GuidanceSystem < System
  def initialize(entity_manager:)
    super(
      component_types: [Position, Hostile, Obstacle],
      entity_manager: entity_manager
    )
  end

  private

  def handle(player_input: nil, entities:)
    return unless player_input && player
    entities.each do |entity|
      new_position = approach_player(entity)
      return unless new_position

      return if CollisionDetector.collision?(position: new_position, entities: entities)

      if new_position == player.position
        player.health.take_hit(1)
        entity_manager.notify(create_message(entity))
      else
        entity.replace_component(
          old_component: entity.position,
          new_component: new_position
        )
      end
    end
  end

  def approach_player(entity)
    ApproachPossibilities.(to_position: player.position, from_position: entity.position).sample
  end

  def create_message(enemy)
    "#{enemy.name.capitalize} hits you!"
  end
end
