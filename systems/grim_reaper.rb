class GrimReaper < System
  def initialize(entity_manager:)
    super(component_types: [Health], entity_manager: entity_manager)
  end

  private

  def handle(player_input: nil, entities:)
    entities
      .select { |entity| entity.health.hp <= 0 }
      .each do |entity|
        entity_manager.remove(entity)
        entity_manager.add(create_message(entity))
      end
  end

  def create_message(enemy)
    message = "Enemy #{enemy.id} killed"
    Entity.new.tap do |e|
      e.add_component(Message.new(message))
      e.add_component(Ttl.new(3))
    end
  end
end
