$LOAD_PATH.unshift "."

require 'pp'
require 'pry'
require 'logger'
require 'curses'

require 'ui'
require 'title_screen'
require 'entity'
require 'world'

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

require 'systems/system'
require 'systems/movement_system'
require 'systems/trap_system'
require 'systems/background_rendering'
require 'systems/element_rendering'
require 'systems/stats_rendering'


$logger = Logger.new('debug.log')

ui = UI.new
world = World.new
roomable = Roomable.new(min_x: 8, min_y: 8, max_x: 12, max_y: 12)

hero = Entity.new
hero_position = Position.new(x: 10, y:10)
hero.add_component(hero_position)
hero.add_component(roomable)
hero.add_component(Presentable.new(sign: '@'))
hero.add_component(PlayerMovable.new)
hero.add_component(Obstacle.new)
hero.add_component(Health.new(hp: 10))

rock = Entity.new
rock_position = Position.new(x: 11, y:10)
rock.add_component(rock_position)
rock.add_component(roomable)
rock.add_component(Obstacle.new)
rock.add_component(Presentable.new(sign: 'o'))

trap = Entity.new
trap.add_component(Position.new(x: 11, y:11))
trap.add_component(roomable)
trap.add_component(Trap.new(damage: 2))
trap.add_component(Presentable.new(sign: 'e'))

world.add_entity(hero)
world.add_entity(rock)
world.add_entity(trap)
world.add_system(MovementSystem.new)
world.add_system(TrapSystem.new)
world.add_system(BackgroundRendering.new(ui: ui))
world.add_system(ElementRendering.new(ui: ui))
world.add_system(StatsRendering.new(ui: ui))

TitleScreen.new(ui: ui).show
world.update(player_input: PlayerInput.new(key: Curses::KEY_ENTER))

loop do
  player_input = PlayerInput.new(key: ui.prompt)

  return if player_input.key == 'q'
  world.update(player_input: player_input)
end

ui.close
