class Health < Component
  attr_reader :hp

  def initialize(hp:)
    @hp = hp
  end

  def take_hit(damage)
    @hp -= damage
  end
end
