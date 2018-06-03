$LOAD_PATH.unshift "."

require 'pp'
require 'pry'
require 'logger'
require 'curses'

require 'ui'
require 'title_screen'
require 'entity'
require 'entity_manager'
require 'world'

require 'config'

require 'components/component'
require 'components/position'
require 'components/player_input'
require 'components/movement'
require 'components/roomable'
require 'components/presentable'
require 'components/player_movable'
require 'components/health'
require 'components/obstacle'
require 'components/trap'
require 'components/message'
require 'components/ttl'
require 'components/hostile'

require 'systems/system'
require 'systems/movement_system'
require 'systems/trap_system'
require 'systems/background_rendering'
require 'systems/element_rendering'
require 'systems/stats_rendering'
require 'systems/attacking_system'
require 'systems/message_rendering'
require 'systems/ttl_cleaner'
require 'systems/grim_reaper'
require 'systems/approach_possibilities'
require 'systems/guidance_system'

require 'entities/enemies/spider'

require 'lib/messenger'
require 'lib/collision_detector'
require 'lib/position_lottery'

$logger = Logger.new('debug.log')

ui = UI.new
entity_manager = EntityManager.new
world = World.new(entity_manager: entity_manager)
roomable = Roomable.new(min_x: 8, min_y: 8, max_x: 12, max_y: 12)
position_lottery = PositionLottery.new(entity_manager: entity_manager)

hero = Entity.new
hero.add_component(position_lottery.draw(room: roomable))
hero.add_component(roomable)
hero.add_component(Presentable.new(sign: '@'))
hero.add_component(PlayerMovable.new)
hero.add_component(Obstacle.new)
hero.add_component(Health.new(hp: 10))

spider = Spider.new
spider.add_component(position_lottery.draw(room: roomable))
spider.add_component(roomable)

trap = Entity.new
trap.add_component(position_lottery.draw(room: roomable))
trap.add_component(roomable)
trap.add_component(Trap.new(damage: 2))
trap.add_component(Presentable.new(sign: 'e'))

world.add_entity(hero)
world.add_entity(spider)
world.add_entity(trap)

world.add_system(AttackingSystem.new(entity_manager: entity_manager))
world.add_system(GrimReaper.new(entity_manager: entity_manager))
world.add_system(MovementSystem.new(entity_manager: entity_manager))
world.add_system(GuidanceSystem.new(entity_manager: entity_manager))
world.add_system(TrapSystem.new(entity_manager: entity_manager))
world.add_system(BackgroundRendering.new(ui: ui, entity_manager: entity_manager))
world.add_system(ElementRendering.new(ui: ui, entity_manager: entity_manager))
world.add_system(StatsRendering.new(ui: ui, entity_manager: entity_manager))
world.add_system(MessageRendering.new(ui: ui, entity_manager: entity_manager))
world.add_system(TtlCleaner.new(entity_manager: entity_manager))

TitleScreen.new(ui: ui).show
player_input = PlayerInput.new(key: ui.prompt)
ui.clear
world.update(player_input: player_input)

loop do
  player_input = PlayerInput.new(key: ui.prompt)

  return if player_input.key == 'q'
  world.update(player_input: player_input)
end

ui.close
