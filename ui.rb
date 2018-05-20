require 'curses'

class UI
  include Curses

  def initialize
    noecho
    init_screen
    crmode
    curs_set(0)
  end

  def close
    close_screen
  end

  def clear
    super
  end

  def map_window
    @map_window ||= Curses::Window.new(30, 120, 1, 1).tap do |window|
      window.box("|", "-")
      window.refresh
    end
  end

  def message(y, x, string)
    x = x + cols if x < 0
    y = y + lines if y < 0

    setpos(y, x)
    addstr(string)
  end

  def prompt
    getch
  end
end
