class StatsRendering < System
  def initialize(ui:)
    @ui = ui
    super(component_types: [PlayerMovable])
  end

  private

  def handle(player_input: nil, entities:)
    $logger.info(entities)
    player = entities.first
    return unless player

    ui.stats_window.setpos(1, 1)
    ui.stats_window << "HP: #{player.health.hp.to_s.rjust(4)}"
    ui.stats_window.refresh
  end

  attr_reader :ui
end
