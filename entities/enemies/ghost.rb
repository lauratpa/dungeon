class Ghost < Entity
  def initialize(config: Config.enemies.find('ghost'))
    super()

    add_component(Obstacle.new)
    add_component(Health.new(hp: config.fetch('hp')))
    add_component(Hostile.new)
    add_component(Presentable.new(path: config.fetch('sprite')))
  end
end
