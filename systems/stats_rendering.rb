class StatsRendering < System
  def initialize(ui:, entity_manager:)
    @ui = ui
    super(
      component_types: [PlayerMovable],
      entity_manager: entity_manager
    )
  end

  private

  def handle(player_input: nil, entities:)
    ui.stats_window.setpos(1, 1)
    ui.stats_window << "HP: #{player.health.hp.to_s.rjust(4)}"
    ui.stats_window.refresh
  end

  attr_reader :ui
end
