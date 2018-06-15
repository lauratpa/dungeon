$LOAD_PATH.unshift "."

require 'memory_profiler'

# MemoryProfiler.start
require 'ruby2d'

require 'entity'
require 'entity_manager'
require 'world'

require 'config'

require 'components/component'
require 'components/position'
require 'components/obstacle'
require 'components/health'
require 'components/hostile'
require 'components/player_movable'
require 'components/2d/presentable'
require 'components/movement' # should be in lib
require 'components/2d/game_image'

require 'systems/system'
require 'systems/2d/movement_system'
require 'systems/attacking_system'
require 'systems/grim_reaper'

require 'lib/room_generator'
require 'lib/collision_detector'

require 'entities/enemies/ghost'

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
hero.add_component(Health.new(hp: 10))
hero.add_component(GameImage.new(x: hero.position.x, y: hero.position.y, path: hero.presentable.path))

ghost = Ghost.new
ghost.add_component(Position.new(x: 7, y: 9))
ghost.add_component(GameImage.new(x: ghost.position.x, y: ghost.position.y, path: ghost.presentable.path))

world.add_entity(hero)
world.add_entity(ghost)

world.add_system(MovementSystem.new(entity_manager: entity_manager))
world.add_system(AttackingSystem.new(entity_manager: entity_manager))
world.add_system(GrimReaper.new(entity_manager: entity_manager))

on :key_down do |e|
  case e.key
  when 'q'
    # report = MemoryProfiler.stop
    # report.pretty_print(to_file: 'stats')
    close
  else
    world.update(player_input: e)
  end
end

update do
  world.update(player_input: nil)
end

show
