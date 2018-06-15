class GameImage < Component
  attr_reader :image

  def initialize(x:, y:, path:)
    @image = Image.new({ x: x * 8, y: y * 8, path: path })
  end

  def remove
    image.remove
  end
end
