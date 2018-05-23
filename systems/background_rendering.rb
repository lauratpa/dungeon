# Should be called room rendering perhaps

class BackgroundRendering < System
  FLOOR = '.'

  def initialize(ui:)
    @ui = ui
    super(component_types: [Roomable])
  end

  private

  def handle(player_input: nil, entities:)
    entities.map(&:roomable).uniq.each do |room|
      width = room.max_x - room.min_x
      height = room.max_y - room.min_y

      # Draw floor and walls
      (height + 2).times do |i|
        ui.map_window.setpos(room.min_y + i - 1, room.min_x - 1)
        case i
        when 0
          ui.map_window << '┌' + '─'* width + '┐'
        when height + 1
          ui.map_window << '└' + '─'* width + '┘'
        else
          ui.map_window << '│' + FLOOR * width + '│'
        end
        ui.map_window.refresh
      end
    end
  end

  attr_reader :ui
end
