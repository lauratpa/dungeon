class Presentable < Component
  attr_reader :path

  def initialize(path:)
    @path = path
  end
end
