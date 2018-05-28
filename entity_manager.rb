class EntityManager
  def initialize
    @entities = Set.new
  end

  def add(entity)
    entities.add(entity)
  end

  def remove(entity)
    entities.delete(entity)
  end

  def select(component_types:)
    entities.select do |entity|
      entity.components.map(&:type).to_set.superset?(component_types)
    end
  end

  private

  attr_reader :entities
end
