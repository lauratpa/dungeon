class Trap < Component
  attr_reader :damage

  def initialize(damage:)
    @damage = damage
  end
end
