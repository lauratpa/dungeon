class GuidanceSystem < System
  def initialize(entity_manager:)
    super(
      component_types: [Position, Roomable, Hostile, Obstacle],
      entity_manager: entity_manager
    )
  end

  private

  def handle(player_input: nil, entities:)
    entities.each do |entity|
      new_position = approach_player(entity)
      return unless new_position

      room = entity.roomable

      occupied_positions = entities
        .tap { |ents| ents.delete(player) }
        .map { |ents| ents.position }

      return unless position_within_room?(position: new_position, room: room)
      return if hits_an_object?(position: new_position, occupied_positions: occupied_positions)

      if new_position == player.position
        player.health.take_hit(1)
        entity_manager.add(create_message(entity))
      else
        entity.replace_component(
          old_component: entity.position,
          new_component: new_position
        )
      end
    end
  end

  def player
    entity_manager.player
  end

  def approach_player(entity)
    ApproachPossibilities.(to_position: player.position, from_position: entity.position).sample
  end

  def hits_an_object?(position:, occupied_positions:)
    occupied_positions.any? { |o| o.attributes == position.attributes }
  end

  def position_within_room?(position:, room:)
    (room.min_x <= position.x && position.x < room.max_x) &&
      (position.y >= room.min_y && room.max_y > position.y)
  end

  def create_message(enemy)
    message = "Enemy #{enemy.id} hits you!"
    Entity.new.tap do |e|
      e.add_component(Message.new(message))
      e.add_component(Ttl.new(3))
    end
  end
end
