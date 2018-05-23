class Presentable < Component
  attr_reader :sign

  def initialize(sign:)
    @sign = sign
  end
end
