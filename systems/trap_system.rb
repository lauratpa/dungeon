class TrapSystem < System
  def initialize
    super(component_types: [Position, Roomable])
  end

  private

  def handle(player_input:, entities:)
    player = entities.detect do |entity|
      entity.components.map(&:type).to_set.superset?([PlayerMovable].to_set)
    end
    return unless player

    triggered_traps = entities
      .tap { |entities| entities.delete(player) }
      .select { |entity| entity.respond_to?(:trap) }
      .select { |trap| trap.position.attributes == player.position.attributes }

    return if triggered_traps.empty?

    triggered_traps.each do |entity|
      player.health.take_hit(entity.trap.damage)
    end
  end
end
