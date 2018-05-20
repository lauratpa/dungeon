require 'securerandom'
require 'set'

class Entity
  attr_reader :id, :components

  def initialize
    @id = SecureRandom.uuid
    @components = Set.new
  end

  def to_s
    "Entity {#{id}: #{self.class.name}}"
  end

  def add_component(component)
    components.add(component)
  end

  def replace_component(old_component:, new_component:)
    components.delete(old_component)
    add_component(new_component)
  end
end
