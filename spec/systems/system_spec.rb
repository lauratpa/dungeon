require './systems/system'
require './components/component'
require './entity'

RSpec.describe System do
  describe '#update' do
    let(:a) { Class.new(Component).tap { |klass| stub_const('A', klass) }}
    let(:b) { Class.new(Component).tap { |klass| stub_const('B', klass) }}
    let(:c) { Class.new(Component).tap { |klass| stub_const('C', klass) }}

    let(:entity_with_a) { Entity.new.tap { |e| e.add_component(a.new) } }
    let(:entity_with_c) { Entity.new.tap { |e| e.add_component(c.new) } }
    let(:entity_with_ab) do
      Entity.new.tap do |e|
        e.add_component(a.new)
        e.add_component(b.new)
      end
    end
    let(:entity_with_ac) do
      Entity.new.tap do |e|
        e.add_component(a.new)
        e.add_component(c.new)
      end
    end
    let(:entity_with_abc) do
      Entity.new.tap do |e|
        e.add_component(a.new)
        e.add_component(b.new)
        e.add_component(c.new)
      end
    end

    let(:system_class) do
      Class.new(System) do
        def handle(player_input: player_input, entities: entities)
          entities
        end
      end
    end

    it 'updates only entities that include the desired components' do
      system = system_class.new(component_types: [a, b])
      entities = [
        entity_with_a,
        entity_with_ab,
        entity_with_abc,
        entity_with_c,
        entity_with_ac
      ]

      expect(system.update(player_input: nil, entities: entities))
        .to contain_exactly(entity_with_ab, entity_with_abc)
    end
  end
end
