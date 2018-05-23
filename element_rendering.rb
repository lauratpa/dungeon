class ElementRendering < System
  def initialize(ui:)
    @ui = ui
    super(component_types: [Position, Presentable])
  end

  def handle(player_input: nil, entities:)
    entities.each do |entity|
      position = entity.position
      presentation = entity.presentable

      ui.map_window.setpos(position.y, position.x)
      ui.map_window << presentation.sign
      ui.map_window.refresh
    end
  end

  private

  attr_reader :ui
end
