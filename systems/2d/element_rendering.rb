class ElementRendering < System
  def initialize(entity_manager:)
    super(
      component_types: [Position, Presentable],
      entity_manager: entity_manager
    )
  end

  def handle(player_input: nil, entities:)
    entities.tap { |ents| ents << player }.each do |entity|
    end
  end
end
