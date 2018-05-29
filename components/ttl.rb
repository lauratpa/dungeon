class Ttl < Component
  attr_reader :ttl

  def initialize(ttl)
    @ttl = ttl
  end

  def decrement
    @ttl -= 1
  end
end
