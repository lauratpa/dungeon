require './lib/approach_possibilities'
require './components/component'
require './components/position'

RSpec.describe ApproachPossibilities do
  let(:to_position) { Position.new(x: 1, y: 1) }
  describe 'when given positions are equal' do
    it 'returns en empty array' do
      expect(described_class.call(to_position: to_position, from_position: to_position)).to be_empty
    end
  end

  describe 'when from position is one step away' do
    it 'returns en empty array' do
      from_position = Position.new(x: 1, y: 2)

      expect(described_class.call(to_position: to_position, from_position: from_position))
        .to contain_exactly(Position.new(x: 1, y: 1))
    end
  end

  describe 'when from position is one step away but farther' do
    it 'returns en empty array' do
      from_position = Position.new(x: 1, y: 3)

      expect(described_class.call(to_position: to_position, from_position: from_position))
        .to contain_exactly(Position.new(x: 1, y: 2))
    end
  end

  describe 'when from position is two steps away' do
    it 'returns en empty array' do
      from_position = Position.new(x: 2, y: 2)

      expect(described_class.call(to_position: to_position, from_position: from_position))
        .to contain_exactly(Position.new(x: 1, y: 2), Position.new(x: 2, y: 1))
    end
  end
end
