# Wrapper class of curses.
# It puts a character on the terminal while it listen stdin to receive command.
# The following commands are available;
#   row:int col:int a:char -> put character on (row, col) ex)10 5 a
#   /update                -> update screen
#   /end                   -> terminate vdisp

require 'curses'

class Display
  attr_accessor :height, :width
  include Curses

  def initialize
    init_screen
    @height = lines
    @width = cols
  end

  def clear_line(row)
    setpos row, 0
    deleteln
  end

  def put_ch(row, col, ch)
    setpos row, col
    addch ch
  end

  def put_str(row, col, str)
    setpos row, col
    addstr str
  end

  def input_ch
    getch
  end

  def input_str
    getstr
  end

  def update
    doupdate
  end

  def destroy
    close_screen
  end
end
