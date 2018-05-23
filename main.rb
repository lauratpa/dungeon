$LOAD_PATH.unshift "."

require 'pp'
require 'pry'
require 'logger'
require 'curses'

require 'ui'
require 'component'
require 'position'
require 'entity'
require 'world'
require 'system'
require 'player_input'
require 'movement_system'
require 'movement'
require 'roomable'
require 'presentable'
require 'player_movable'
require 'background_rendering'
require 'element_rendering'
require 'title_screen'

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
