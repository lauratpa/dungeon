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

require 'systems/system'
require 'systems/movement_system'
require 'systems/background_rendering'
require 'systems/element_rendering'


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

rock = Entity.new
rock_position = Position.new(x: 11, y:10)
rock.add_component(rock_position)
rock.add_component(roomable)
rock.add_component(Presentable.new(sign: 'o'))

world.add_entity(hero)
world.add_entity(rock)
world.add_system(MovementSystem.new)
world.add_system(BackgroundRendering.new(ui: ui))
world.add_system(ElementRendering.new(ui: ui))

TitleScreen.new(ui: ui).show
world.update(player_input: PlayerInput.new(key: Curses::KEY_ENTER))

loop do
  player_input = PlayerInput.new(key: ui.prompt)

  return if player_input.key == 'q'
  world.update(player_input: player_input)
end

ui.close
