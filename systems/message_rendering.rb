class MessageRendering < System
  def initialize(ui:, entity_manager:)
    @ui = ui
    super(
      component_types: [Message],
      entity_manager: entity_manager
    )
  end

  private

  def handle(player_input: nil, entities:)
    return unless entities

    entities.each_with_index do |entity, i|
      ui.message_window.setpos(1 + i, 1)
      ui.message_window << entity.message.message.ljust(ui.message_window.maxx - 2)
      ui.message_window.refresh

      entity.ttl.decrement
    end
  end
  attr_reader :ui
end
