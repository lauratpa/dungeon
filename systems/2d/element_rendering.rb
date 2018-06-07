class ElementRendering < System
  def initialize(entity_manager:)
    super(
      component_types: [Position, Presentable],
      entity_manager: entity_manager
    )
  end

  def handle(player_input: nil, entities:)
    entities.tap { |ents| ents << player }.each do |entity|
      Image.new({
        x: entity.position.x * 8, y: entity.position.y * 8,
        path: entity.presentable.path
      })
    end
  end
end
