$LOAD_PATH.unshift "."

require 'pry'
require 'gosu'

require 'config'

require 'entity'
require 'entity_manager'
require 'world'

require 'components/component'
require 'components/position'
require 'components/obstacle'
require 'components/health'
require 'components/hostile'
require 'components/player_movable'
require 'components/presentable'
require 'components/game_image'

require 'lib/movement'
require 'lib/room_generator'
require 'lib/collision_detector'
require 'lib/approach_possibilities'

require 'systems/system'
require 'systems/rendering_system'
require 'systems/movement_system'
require 'systems/attacking_system'
require 'systems/grim_reaper'
require 'systems/guidance_system'

require 'entities/enemies/ghost'

class Dungeon < Gosu::Window
  def initialize(world:, render:)
    super 320, 200
    self.caption = 'Dungeon'

    self.fullscreen = true
    self.update_interval = 100
    @world = world
    @render = render
  end

  def draw
    @render.update(player_input: 'a')
  end

  def update
    case
    when Gosu.button_down?(Gosu::KB_H)
      @world.update(player_input: 'h')
    when Gosu.button_down?(Gosu::KB_J)
      @world.update(player_input: 'j')
    end
    if Gosu.button_down?(Gosu::KB_K)
      @world.update(player_input: 'k')
    end
    if Gosu.button_down?(Gosu::KB_L)
      @world.update(player_input: 'l')
    end
  end
end

entity_manager = EntityManager.new
world = World.new(entity_manager: entity_manager)

RoomGenerator.call(x: 5, y: 6, height: 9, width: 9).each do |tile|
  world.add_entity(tile)
end

hero = Entity.new
hero.add_component(Position.new(x: 6, y: 8))
hero.add_component(Presentable.new(path: './data/hero1.png'))
hero.add_component(PlayerMovable.new)
hero.add_component(Obstacle.new)
hero.add_component(Health.new(hp: 10))
hero.add_component(GameImage.new(path: hero.presentable.path))

ghost = Ghost.new
ghost.add_component(Position.new(x: 9, y: 10))
ghost.add_component(GameImage.new(path: ghost.presentable.path))

world.add_entity(hero)
world.add_entity(ghost)

render = RenderingSystem.new(entity_manager: entity_manager)
world.add_system(MovementSystem.new(entity_manager: entity_manager))
world.add_system(AttackingSystem.new(entity_manager: entity_manager))
world.add_system(GrimReaper.new(entity_manager: entity_manager))
world.add_system(GuidanceSystem.new(entity_manager: entity_manager))

Dungeon.new(world: world, render: render).show
