class BackgroundRendering < System
  def initialize(entity_manager:)
    super(
      component_types: [Roomable, Presentable],
      entity_manager: entity_manager
    )
  end

  private

  def handle(player_input: nil, entities:)
    entities.map(&:roomable).uniq.each do |room|
      x_positions = (room.min_x..room.max_x).to_a
      y_positions = (room.min_y..room.max_y).to_a

      x_positions.product(y_positions).each do |x, y|
        Image.new({ x: x * 32, y: y * 32, path: './data/dirt0.png'})
      end
    end
  end
end
