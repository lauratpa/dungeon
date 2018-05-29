class Message < Component
  attr_reader :message
  attr_accessor :ttl

  def initialize(message)
    @message = message
    @ttl = 4
  end
end
