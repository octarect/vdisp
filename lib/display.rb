# wrapper class of curses.
# it puts a character on the terminal while it listen stdin to receive command.
# the following commands are available;
#   row:int col:int a:char -> put character on (row, col) ex)10 5 a
#   /update                -> update screen
#   /end                   -> terminate vdisp

require 'curses'

require 'logger'

class Display
  include Curses

  def initialize(debug: false)
    # output log when debug_mode is enabled
    @debug_mode = debug
    @logger = Logger.new './display.log' if @debug_mode
    # initialize curses
    init_screen
  end

  def listen
    # listen until vdisp receive /end
    loop do
      clear_buffer
      command = getstr
      break if command == '/end'
      if command == '/update'
        log '[refreshed]'
        doupdate
        next
      end
      next if command.empty?
      log "[received]command=#{command} empty?=<#{command.empty?}>"
      params = command.split ' '
      setpos params[0].to_i, params[1].to_i
      addch params[2].to_s
    end
    stop
  end

  def clear_buffer
    setpos lines - 1, 0
    deleteln
  end

  def log(msg)
    @logger.output msg if @debug_mode
  end

  def stop
    close_screen
    @log.close if @debug_mode
  end
end
