require 'curses'

class UI
  include Curses

  def initialize
    noecho # Don't show pressed keys
    start_color # Show colors
    crmode # React to each pressed key
    curs_set(0) # Make cursors invisible
    init_screen # Start
  end

  def close
    close_screen
  end

  def clear
    super
  end

  # Window for showing the map
  def map_window
    @map_window ||= Curses::Window.new(30, 120, 1, 1).tap do |window|
      window.box("|", "-")
      window.refresh
    end
  end

  def message(y:, x:, str:)
    x = x + cols if x < 0
    y = y + lines if y < 0

    setpos(y, x)
    addstr(str)
    refresh
  end

  def prompt
    getch
  end
end
