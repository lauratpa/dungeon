UnknownMovementPattern = Class.new(ArgumentError)

class Movement
  def self.call(player_input:)
    case player_input.key
    when 'k' then { coordinate: :y, value: 1 }
    when 'l' then { coordinate: :x, value: 1 }
    when 'j' then { coordinate: :y, value: -1 }
    when 'h' then { coordinate: :x, value: -1 }
    else raise UnknownMovementPattern, player_input
    end
  end
end
