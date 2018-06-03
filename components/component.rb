require 'securerandom'

class Component
  attr_reader :id

  def initialize
    @id = SecureRandom.uuid
  end

  def to_s
    "Component {#{id}: #{self.class.name}}"
  end

  def type
    self.class
  end

  def type_name
    type.to_s.downcase
  end
end
