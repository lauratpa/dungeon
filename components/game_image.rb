class GameImage < Component
  attr_reader :image, :z

  def initialize(z: 1, path:)
    @image = Gosu::Image.new(path, tileable: true)
    @z = z
  end

  def draw(x, y)
    image.draw(x * 8, y * 8, z)
  end
end
