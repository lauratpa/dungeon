$LOAD_PATH.unshift "."

require 'ruby2d'

require 'entity'
require 'entity_manager'
require 'world'

require 'config'

require 'components/component'
require 'components/position'
require 'components/obstacle'
require 'components/player_movable'
require 'components/2d/presentable'
require 'components/movement' # should be in lib

require 'systems/system'
require 'systems/2d/element_rendering'
require 'systems/2d/movement_system'

require 'lib/room_generator'
require 'lib/collision_detector'

set(
  {
    title: 'Dungeon',
    background: '#343e71',
    fullscreen: true,
    width: 320,
    height: 200
  }
)

entity_manager = EntityManager.new
world = World.new(entity_manager: entity_manager)

RoomGenerator.call(x: 5, y: 6, height: 6, width: 5).each do |tile|
  world.add_entity(tile)
end

hero = Entity.new
hero.add_component(Position.new(x: 6, y: 8))
hero.add_component(Presentable.new(path: './data/hero1.png'))
hero.add_component(PlayerMovable.new)
hero.add_component(Obstacle.new)
# hero.add_component(Health.new(hp: 10))

world.add_entity(hero)

world.add_system(ElementRendering.new(entity_manager: entity_manager))
world.add_system(MovementSystem.new(entity_manager: entity_manager))

tick = 0

on :key_down do |e|
  case e.key
  when 'q' then close
  else
    world.update(player_input: e)
  end
end

update do
  world.update(player_input: nil)
end

show
