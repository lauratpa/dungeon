class BackgroundRendering < System
  FLOOR = '.'

  def initialize(ui:)
    @ui = ui
    super(component_types: [Roomable])
  end

  def handle(player_input: nil, entities:)
    rooms = entities.map do |entity|
      entity.components.detect do |component|
        component.type == Roomable
      end
    end.uniq

    rooms.each do |room|
      width = room.max_x - room.min_x
      height = room.max_y - room.min_y

      height.times do |i|
        ui.map_window.setpos(room.min_y + i, room.min_x)
        ui.map_window << FLOOR * width
        ui.map_window.refresh
      end
    end
  end

  private

  attr_reader :ui
end
