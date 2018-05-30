class TrapSystem < System
  def initialize(entity_manager:)
    super(
      component_types: [Position, Roomable],
      entity_manager: entity_manager
    )
  end

  private

  def handle(player_input:, entities:)
    player = entity_manager.player

    triggered_traps = entities
      .tap { |entities| entities.delete(player) }
      .select { |entity| entity.respond_to?(:trap) }
      .select { |trap| trap.position.attributes == player.position.attributes }

    return if triggered_traps.empty?

    triggered_traps.each do |entity|
      player.health.take_hit(entity.trap.damage)
      entity_manager.remove(entity)
      entity_manager.notify(create_message(entity))
    end
  end

  def create_message(enemy)
    "You stepped on trap!"
  end
end
