class ElementRendering < System
  def initialize(ui:)
    @ui = ui
    super(component_types: [Position, Presentable])
  end

  def handle(player_input: nil, entities:)
    elements = entities.map do |entity|
      entity.components.select do |component|
        component_types.include?(component.type)
      end
    end

    elements.each do |presentation, position|
      ui.map_window.setpos(position.y, position.x)
      ui.map_window << presentation.sign
      ui.map_window.refresh
    end
  end

  private

  attr_reader :ui
end
