class Messenger
  def self.call(message)
    Entity.new.tap do |e|
      e.add_component(Message.new(message))
      e.add_component(Ttl.new(3))
    end
  end
end
