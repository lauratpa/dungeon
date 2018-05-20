class System
  def initialize(component_types:)
    @component_types = component_types.to_set
  end

  def update(player_input:, entities:)
    selected_entities = entities.select do |entity|
      entity.components.map(&:type).to_set.superset?(component_types)
    end

    handle(player_input: player_input, entities: selected_entities)
  end

  private

  attr_reader :component_types

  def handle
    raise NotImplementedError
  end
end
