require './entity'
require './components/component'

RSpec.describe Entity do
  let(:component_class) { Class.new(Component).tap { |klass| stub_const('ABC', klass) } }

  it 'components can be accessed as methods' do
    entity = Entity.new
    component = component_class.new
    entity.add_component(component)
    expect(entity.abc).to eq(component)
  end

  it 'unexisting components throw exception' do
    entity = Entity.new
    method = :abc
    expect{ entity.send(method) }.to raise_error(NoMethodError)
  end
end
