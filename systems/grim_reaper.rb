class GrimReaper < System
  def initialize(entity_manager:)
    super(component_types: [Health], entity_manager: entity_manager)
  end

  private

  def handle(player_input: nil, entities:)
    entities
      .tap { |ents| ents << player if player }
      .select { |entity| entity.health.hp <= 0 }
      .each do |entity|
        entity_manager.remove(entity)
        entity.gameimage.remove
        entity_manager.notify(create_message(entity))
      end
  end

  def create_message(enemy)
    "#{enemy.name.capitalize} killed"
  end
end
