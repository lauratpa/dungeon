require 'set'

class World
  def initialize
    @entities = Set.new
    @systems = []
  end

  def add_entity(entity)
    entities.add(entity)
  end

  def add_system(system)
    systems << system
  end

  def update(player_input:)
    systems.each do |system|
      system.update(player_input: player_input, entities: entities)
    end
  end

  private

  attr_reader :entities, :systems
end
