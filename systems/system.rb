class System
  def initialize(component_types:, entity_manager:)
    @component_types = component_types.to_set
    @entity_manager = entity_manager
  end

  def update(player_input:)
    selected_entities = entity_manager.select(
      component_types: component_types
    )

    handle(player_input: player_input, entities: selected_entities)
  end

  private

  attr_reader :component_types, :entity_manager

  def handle(player_input:, entities:)
    raise NotImplementedError
  end
end
