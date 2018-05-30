class AttackingSystem < System
  def initialize(entity_manager:)
    super(
      component_types: [Position, Roomable],
      entity_manager: entity_manager
    )
  end

  private

  def handle(player_input:, entities:)
    movement = Movement.call(player_input: player_input)
    return unless movement

    player = entity_manager.player

    attributes = player.position.attributes
    coordinate = movement.fetch(:coordinate)
    value = movement.fetch(:value)
    attributes[coordinate] = attributes[coordinate] + value

    new_position = Position.new(attributes)

    attacked_enemies = entities
      .tap { |entities| entities.delete(player) }
      .select { |entity| entity.respond_to?(:foe) }
      .select { |enemy| enemy.position.attributes == new_position.attributes }

    return if attacked_enemies.empty?

    attacked_enemies.each do |entity|
      entity.health.take_hit(1)
      entity_manager.add(create_message(entity))
    end
  end

  def create_message(enemy)
    message = "Enemy #{enemy.id} HP #{enemy.health.hp}"
    Entity.new.tap do |e|
      e.add_component(Message.new(message))
      e.add_component(Ttl.new(3))
    end
  end
end
