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

  def notify(message)
    puts message
  end

  def player
    entities.detect do |entity|
      entity.respond_to?(:playermovable)
    end
  end

  def select(component_types:)
    entities.select do |entity|
      entity.components.map(&:type).to_set.superset?(component_types)
    end
  end

  private

  attr_reader :entities
end
