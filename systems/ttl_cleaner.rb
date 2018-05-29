class TtlCleaner < System
  def initialize(entity_manager:)
    super(component_types: [Ttl], entity_manager: entity_manager)
  end

  def handle(player_input: nil, entities:)
    entities.each do |entity|
      entity_manager.remove(entity) if entity.ttl.ttl <= 0
    end
  end
end
