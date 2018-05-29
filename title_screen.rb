class TitleScreen
  TITLE = <<-TXT
  8888888b.                                                        
  888  "Y88b                                                       
  888    888                                                       
  888    888 888  888 88888b.   .d88b.   .d88b.   .d88b.  88888b.  
  888    888 888  888 888 "88b d88P"88b d8P  Y8b d88""88b 888 "88b 
  888    888 888  888 888  888 888  888 88888888 888  888 888  888 
  888  .d88P Y88b 888 888  888 Y88b 888 Y8b.     Y88..88P 888  888 
  8888888P"   "Y88888 888  888  "Y88888  "Y8888   "Y88P"  888  888 
                                    888                            
                               Y8b d88P                            
                                "Y88P"                             
  TXT

  def initialize(ui:)
    @ui = ui
    @title = TITLE.split("\n")

    Curses.init_pair(1, Curses::COLOR_GREEN, Curses::COLOR_BLACK)
    Curses.attrset(Curses.color_pair(1))
  end

  def show
    start_y = (Curses.lines - title.size) / 2
    start_x = (Curses.cols - title.first.size) / 2

    title.each_with_index do |row, i|
      ui.message(y: start_y + i, x: start_x, str: row)
    end

    message = 'PRESS ANY KEY'
    ui.message(
      y: start_y + title.size + 3,
      x: (Curses.cols - message.size) / 2 + 2,
      str: message
    )
  end

  private

  attr_reader :ui, :title
end
