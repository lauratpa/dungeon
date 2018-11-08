class Movement
  def self.call(player_input:)
    case player_input
    when 'k' then { coordinate: :y, value: 1 }
    when 'l' then { coordinate: :x, value: 1 }
    when 'j' then { coordinate: :y, value: -1 }
    when 'h' then { coordinate: :x, value: -1 }
    end
  end
end
