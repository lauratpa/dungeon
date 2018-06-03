require 'yaml'

class Config
  KeyNotFound = Class.new(StandardError)

  def self.enemies
    @enemies = Collection.new(YAML.load_file('data/enemies.yml'))
  end

  class Collection
    def initialize(hsh)
      @hsh = hsh
    end

    def find(key)
      hsh.detect { |el| el.fetch('name') == key } or raise KeyNotFound.new("for: '#{key}'")
    end

    private

    attr_reader :hsh
  end
end
