class AttackingSystem < System
  def initialize(entity_manager:)
    super(
      component_types: [Position],
      entity_manager: entity_manager
    )
  end

  private

  def handle(player_input:, entities:)
    return unless player_input

    movement = Movement.call(player_input: player_input)
    return unless movement

    attributes = player.position.attributes
    coordinate = movement.fetch(:coordinate)
    value = movement.fetch(:value)
    attributes[coordinate] = attributes[coordinate] + value

    new_position = Position.new(attributes)

    attacked_enemies = entities
      .tap { |entities| entities.delete(player) }
      .select { |entity| entity.respond_to?(:hostile) }
      .select { |enemy| enemy.position.attributes == new_position.attributes }

    return if attacked_enemies.empty?

    attacked_enemies.each do |entity|
      entity.health.take_hit(1)
      entity_manager.notify(create_message(entity))
    end
  end

  def create_message(enemy)
    "#{enemy.name.capitalize} HP #{enemy.health.hp}"
  end
end
