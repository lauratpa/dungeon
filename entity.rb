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
    raise(ArgumentError, "not a component") unless component.is_a?(Component)

    components.add(component)
  end

  def replace_component(old_component:, new_component:)
    raise(ArgumentError, "not a component") unless new_component.is_a?(Component)

    components.delete(old_component)
    add_component(new_component)
  end

  def method_missing(method, *args)
    component = components.detect { |c| c.type.to_s.downcase == method.to_s }
    super unless component

    define_singleton_method method do
      components.detect { |c| c.type.to_s.downcase == method.to_s }
    end
    component
  end

  def respond_to_missing?(method_name, include_private = false)
    component = components.detect { |c| c.type.to_s.downcase == method.to_s } || super
  end
end
