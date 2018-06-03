class Spider < Entity
  def initialize(config: Config.enemies.find('spider'))
    super()

    add_component(Obstacle.new)
    add_component(Hostile.new)
    add_component(Health.new(hp: config.fetch('hp')))
    add_component(Presentable.new(sign: config.fetch('sign')))
  end
end
