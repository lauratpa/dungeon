class RenderingSystem < System
  def initialize(entity_manager:)
    super(
      component_types: [GameImage, Position],
      entity_manager: entity_manager
    )
  end

  private

  def handle(player_input:, entities:)
    entities
      .tap { |ents| ents << player if player }
      .each do |entity|
	entity.gameimage.draw(entity.position.x, entity.position.y)
      end
  end
end
