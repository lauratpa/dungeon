require 'set'

class World
  def initialize(entity_manager:)
    @entities = Set.new
    @systems = []
    @entity_manager = entity_manager
  end

  def add_entity(entity)
    entity_manager.add(entity)
  end

  def add_system(system)
    systems << system
  end

  def update(player_input:)
    systems.each do |system|
      system.update(player_input: player_input)
    end
  end

  private

  attr_reader :entity_manager, :systems
end
